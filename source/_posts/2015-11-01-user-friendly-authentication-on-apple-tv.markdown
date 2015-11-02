---
layout: post
title: "User-Friendly Authentication on Apple TV"
date: 2015-11-01 22:34:28 -0600
comments: true
categories: tvOS
---

The primary input mechanism for Apple TV text entry is a single thumb on a tiny trackpad. Needless to say, entering text is a nuissance. Entering comlpex passwords is painful. 

So painful, in fact, that I'd expect most people to just drop out and never come back if you present them with a log in screen.

<!-- more -->

Apple recognized this and provided an automatic first-time set up using your iPhone. You wake up your phone and put it close to the device and it sets most things up for you automatically.

For the [NSScreencast](http://nsscreencast.com) app I knew I had to provide a better mechanism for logging in than entering in an email address and password.

I decided to follow the Youtube model, and have you activate the device using your web browser on a a phone or laptop.

When the app needs the user to authenticate, it requests a code from the server. Along with this request, it sends a UUID, unique to the device.

![](/images/nsstvlogin1.jpg)

The server generates an easy to remember code, and saves this information in Redis. It sets an expiration of 5 minutes, which should be enough time to complete the process. This prevents keys from accidentally overlapping for multiple requesting devices.

The Apple TV displays this code along with instructions for the user:

![](/images/nsstvlogin2.jpg)

When the user navigates to this page, it forces them to login. Once authenticated, they are presented with a simple text box:

![](/images/nsstvlogin3.jpg)

The user enters the code that is being displayed on the TV, the system matches the code up with the pending authentication requests, and sends the authentication token to the Apple TV, who has been polling for an answer in the background.

The Apple TV sees the updated status and automatically logs the user in.

![](/images/nsstvlogin4.jpg)

Success! Painless authentication without having to type anything with the remote.

### Alternative: Use your iPhone app

An alternative strategy would be to use an authenticated nearby iPhone to provide authentication. 

I don't (yet) have an iOS app in the store, so this method wasn't available to me.

Black Pixel employed this technique for their TV app, [NetNewsWire Today](http://netnewswireapp.com/tv/). I tried this out and it was a great experience.
