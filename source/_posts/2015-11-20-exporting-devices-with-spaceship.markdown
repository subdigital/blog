---
layout: post
title: "Exporting Devices with Spaceship"
date: 2015-11-20 14:05:10 -0600
comments: true
categories: iOS
---

One of my clients is submitting an app to the store under a different Apple Developer account than it was developed with.

This left us with about 50 devices in the old portal that they were using for development & beta testing. I needed to quickly get these over to the new portal.

<a href="https://spaceship.airforce/">
<img alt="spaceship.airforce" border=0 src="/images/spaceship-logo.png" width="376">
</a>

Enter [spaceship](http://spaceship.airforce).

Spaceship is a gem developed by [Felix Krause](https://krausefx.com) and [Stefan Natchev](https://github.com/snatchev) as part of the [fastlane](http://fastlane.tools) project.

<!-- more -->

Basically it is an interactive command-line interface for dealing with the Dev Center.

It's delivered as a rubygem, so you can install it like this:

```
gem install spaceship
```

You launch it and interact with it in a Ruby repl, like this:

```
> spaceship
Username:  myappleid@me.com
Password (for myappleid@me.com): ******** 
```

Now you're logged in, and the password was saved in the OS X Keychain, so you won't have to enter it in again.

Then you can list devices:

```ruby
Spaceship.device.all
```

In my case I wanted to be sure that I only imported devices related to our existing adhoc provisioning profile. Pretty easy, first get the provisioning profile object:

```ruby
profile = Spaceship.profile.all.select {|p| p.name == "MyAppAdhoc" }.first
```

Then call `devices` on it to get the list of devices:

```ruby
devices = profile.devices
```

Finally, create a file that we can use to import into the new portal:

```ruby
File.open('devices.txt', 'w') do |f|
  f.puts "Device ID\tDevice Name"
  devices.each do |device|
    f.puts "#{device.udid}\t#{device.name}"
  end
end
```

Awesome! Now I have a file I can use to manually upload to the portal, or better yet, use [fastlane](http://fastlane.tools) to manage it all. Easy peasy.
