---
layout: post
title: "Background Downloads"
date: 2016-10-03 14:45:40 -0500
comments: true
categories: ios
---


{%img center http://benpublic.s3.amazonaws.com/blog/background-downloads.png 334 %}

In the [previous post](http://benscheirman.com/2016/09/designing-a-robust-large-file-download-system/), I wrote about how I designed the download system for the [NSScreencast](http://nsscreencast.com) iOS app.

There's no need to have the user be forced to keep our app in the foreground while the download is in progress, we naturally want to support background downloads.

<!-- more -->

On the surface it seems pretty straightforward:  You configure your session with a background session configuration, give it an identifier, and the download will happen in a separate process from your application.

When using background sessions, you cannot use the block-based task API, as the session and delegate might need to be _recreated_ later on to receive updates for a given download. There are many scenarios to consider, but let's first examine the happy path:

- User starts a download, then suspends the app
- After a few seconds (10-30 in my experience) the app will get terminated
- The download continues in a separate process
- When it finishes, your app gets relaunched, and your App's delegate will receive `application(handleEventsForBackgroundSessionWithIdentifier:)` with the identifier you used to start the download

> Tip: When debugging with Xcode, the debugger actually prevents your app from ever being terminated while in the background, so my strategy has been to turn on the option to Wait for Launch, then manually launch the app and kick off the download, and background the app before starting the debugger

When this method is called, your job is to create a new session configuration _with the same identifier_, create a session, and assign your delegate instance. The system _should_ notify your delegate immediately of the status of that download.

But which download was it?

You don't really know. All you can get is the original request's URL, which may be enough information, but it may not be. URLs don't make great keys, as they can change, and they are often not unique. You have http versus https, multiple paths might lead to the same resource, it might redirect, etc. There are just a number of reasons why this won't be helpful to you. In my case I have relatively canonical episode URLs, but they redirect to signed Amazon CloudFront URLs, so they not only not unique, but they are temporal too. So we're sort of stuck with no way to get back to the episode model that we're getting notified about.

This is a strange part of the API that isn't clearly written about in the documentation, but I find that the best strategy here is to create a unique session identifier for each download and save that to your model. Then you can easily find which download you're getting notified about.

OK, so the happy path is settled. What about when things go wrong? What happens if the download fails? What happens if we have cellular access disabled and the download is occurring in the background and they walk out of Wi-Fi range?

For that last case I have some answers. If you've configured a normal session configuration and start a download on Wi-Fi, then turn it off, you'll get an error immediately stating that cellular downloads are not enabled. However, if you're using _background_ sessions, then the system will smartly wait and retry this request later when they _are_ on Wi-Fi.

> This happens for other errors as well, including connection errors where my local server was actually not running, causing my downloads to appear running, but stuck at 0% for what seemed like eternity. After starting my local server, the downloads started as if nothing was ever wrong.

It is not clearly stated in the documentation how long this request will sit waiting to be retried. In fact, if the user launches the app again, what state is the download in? How can we know? During development I've stumbled upon a few cases where a download just gets orphaned. The download info state is `.downloading`, but we've never received a callback for completion, successful or otherwise. The only recourse I have at that time is to mark it as failed, but the main question is... when? Since downloads can take a while and can be retried a few times it's not as simple as marking them failed after X minutes.

This is probably what I'll do, but it doesn't feel right.