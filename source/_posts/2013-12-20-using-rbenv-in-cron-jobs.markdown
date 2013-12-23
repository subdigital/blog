---
layout: post
title: "Using rbenv in cron jobs"
date: 2013-12-20 19:54
comments: true
categories: Ruby
---

When using [rbenv](https://github.com/sstephenson/rbenv) on your server, you need to make sure that any gem command run needs to be executed with rbenv initialized.  When you install rbenv locally or on the server, you typically have something like this added to your `.bashrc`:

```bash
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
...
```

<!-- more -->

> If you're not familiar with bash, this command checks to see if rbenv is installed by asking for the path to the `rbenv` binary.  It throws away the result by redirecting STDOUT to `/dev/null` and uses the exit code of that command to control the if statement.  In Unix, commands that run successfully return a status code of 0, which means that the if block will evaluate to false and not run.  If the binary is not found we'll have some non-zero exit code which evaluates to true, and the body of the if statement will be executed.

If we don't initialize rbenv then we won't be able to see ruby on the system, nor any gems.

## In server cron jobs

When on a server we have the same configuration so our processes run with rbenv already initialized.  The problem comes when you want to use ruby inside of cron jobs.  Cron executes under a limited environment, so your typical `.bash_profile` solution doesn't apply here.  Instead we need to combine the above with our command to get it all to work:

```
15 3 * * * cd /path/to/app && bundle exec rake do_stuff
```

In this example we're trying to run the `do_stuff` rake task at 3:15 AM every day.  This won't work because rake can't be found in the environment that cron runs under.  We can alter the command like this:

```
15 3 * * * export PATH=/opt/rbenv/shims:/opt/rbenv/bin:/usr/bin:$PATH; eval "$(rbenv init -)"; cd /path/to/app && bundle exec rake do_stuff
```

Here we've added the rbenv shims folder to our path and initialize rbenv before running the command.  Now they'll run with rbenv properly initialized.

## Using Whenever

I use the [whenever](https://github.com/javan/whenever) gem to run application level cron jobs.  I like keeping these in the application because it's really easy to tweak and see what gets run and when.  Here's an example from [NSScreencast](http://nsscreencast.com):

```ruby
set :output, "/var/log/cron.log"

every 3.hours do
  rake "episodes:update_counts"
end

every 1.hour do
  rake "episodes:publish"
end

every 1.day, :at => '5:00 am' do
  rake "import_invoices"
end
```

It's pretty easy to see what's going on here and when these tasks will run.  Upon deployment, capistrano will execute the whenever gem to generate the appropriate cron jobs to run these at the specified times.  But the problem that we saw above still applies:  rbenv won't be initialized at this point.  To fix this, we can create a custom job type:

```ruby
job_type :rbenv_rake, %Q{export PATH=/opt/rbenv/shims:/opt/rbenv/bin:/usr/bin:$PATH; eval "$(rbenv init -)"; \
                         cd :path && bundle exec rake :task --silent :output }

```

Now we can use `rbenv_rake` instead of `rake` in our `schedule.rb` file and the commands will include the rbenv initialization above.

