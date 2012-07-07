---
layout: post
title: "Serving Assets from S3 on Heroku"
date: 2012-07-07 11:17
comments: true
categories: rails
---

Recently I changed [NSScreencast](http://nsscreencast.com) to use a [CDN](http://en.wikipedia.org/wiki/Content_delivery_network)
to serve up assets from a different, faster server.

## Why use a CDN?

Using a CDN has numerous benefits.  First, and foremost, this alleviates a bunch of secondary requests that
would normally hit your webserver.  Loading the home page of NSScreencast loads more than a dozen images, stylesheets, and
javascript files.  When deploying to Heroku this can be especially problematic as each asset request will occupy one of your 
dynos for a short time.  In the spirit of maximizing your free dyno on Heroku, not sending these requests to your app is definitely
a big win.

In addition, most browsers have a setting that limits the number of connections (usually 2) that it will open
in parallel to a given domain.  By using a CDN, you can increase the number of parallel requests
because these assets are not served up by your application's domain.

It's also a common practice to use dns to "alter" the domain so that you can maximize this parallelization.

## Using the asset sync gem

Following the instructions on [Heroku's Devcenter article](https://devcenter.heroku.com/articles/cdn-asset-host-rails31) I 
decided to use the `asset_sync` gem.  This gem will upload your compiled assets to your preferred CDN (any file storage server that
[fog](https://github.com/fog/fog/) supports).  In my case, I wanted to use S3.

The first step is adding this gem to your `Gemfile`:

```ruby
group :assets do
  # other asset gems
  gem 'asset_sync'
end
```

It's important to put this in your asset group, as your running app doesn't need to load this into memory.

Then you need to configure the gem.  I found Heroku's instructions to be lacking here, as I had to dig into
the [`asset_sync` github page](https://github.com/rumblelabs/asset_sync) to make this work.

Add a file called `config/initializers/asset_sync.rb` to your app:

```ruby
# Since this gem is only loaded with the assets group, we have to check to 
# see if it's defined before configuring it.
if defined?(AssetSync)
  AssetSync.configure do |config|
    config.fog_provider = 'AWS'
    config.aws_access_key_id = ENV['AWS_ACCESS_KEY_ID']
    config.aws_secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
    config.fog_directory = ENV['FOG_DIRECTORY']

    # Fail silently.  Useful for environments such as Heroku
    config.fail_silently = true
  end
end
```

That last config line is important.  When you deploy to Heroku, your app's assets will get precompiled.  But because Heroku
doesn't initialize your app on precompile, none of your settings will be available.  Instead we'll have to run the precompile again, 
manually, to get AssetSync to kick in.

## Setting up the configuration with Heroku San

Since I like to have multiple environments, I use [`heroku_san`](https://github.com/fastestforward/heroku_san) to manage them, including
the environment variables.

Inside of `config/heroku.yml`, set up the following for each environment:

```
    FOG_PROVIDER: "AWS"
    FOG_DIRECTORY: "nsscreencast-assets"
    AWS_ACCESS_KEY_ID: "<your access key>"
    AWS_SECRET_ACCESS_KEY: "..."
```

## Configuring Your Rails app to use S3 as an Asset Host

In your `config/production.rb` (and `staging.rb` if you have one), make sure to add the
following line to allow Rails to generate the appropriate links for your assets:

```ruby
  config.action_controller.asset_host = Proc.new do |source, request|
    scheme = request.ssl? ? "https" : "http"
    "https://#{ENV['FOG_DIRECTORY']}.s3.amazonaws.com"
  end
```

This will allow your app to serve up the URLs using SSL if the request is coming via SSL.  Doing
this can avoid warnings in the browser that your app contains secure and unsecure content.

## Testing it all out

If all of this is configured correctly, you can test it out by doing a push...

```
git push heroku master
```

You'll see the asset precompile going on in the logs, and likely an error related to AssetSync.  This is fine (and 
in fact, this tripped me up at first).  Once
the deploy has completed, you'll have to run this command to upload your assets:

```
heroku run rake assets:precompile --app <yourapp>
```

Doing this, you should see something like the following output:

```
Precompiling assets...
Uploading: application.css
Uploading: application.css.gz
Uploading: image1.png
Uploading: image2.png
...
```


## Set up Heroku San to do this on every deploy

I'd likely forget to run this command every once in a while, so I set up Heroku San to run this command
after every deploy.

To do this, add a new rake task in your app (`lib/tasks/deploy.rake`):

```ruby
task :after_deploy do
  HerokuSan.project.each_app do |stage|
    puts "---> Precompiling asssets & uploading to the CDN"
    system("heroku run rake assets:precompile --app #{stage.app}")
  end
end
```

Now when you run your deploy via `rake production deploy` this will happen automatically.

## So what's the net result?

Doing this alleviated nearly 30 secondary requests to my application for each page load.  That alone is pretty huge.  Also, S3 is
much faster at serving these assets than nginx is (at least via a Heroku app on 1 dyno).

I tested this before and after by clearing the cache and doing a fresh page load.  Using the Chrome Inspector, I looked at the time to load the page and all assets. 
Here are my findings:

<table style="margin: 25px;">
  <tr>
    <td style="border: solid 1px #ddd; padding: 3px 7px;">
      <strong>Before</strong> (<em>serving assets with no CDN</em>)
    </td>
    <td style="border: solid 1px #ddd; padding: 3px 7px;">3.27 seconds</td>
  </tr>
  <tr>
    <td style="border: solid 1px #ddd; padding: 3px 7px;"><strong>After</strong>
    (<em>using S3 as a CDN</em>)
    </td>
    <td style="border: solid 1px #ddd; padding: 3px 7px;">1.07 seconds</td>
  </tr>
</table>

That's a huge gain for a minor change in your application & deployment process.
