---
layout: post
title: "NSScreencast + tvOS"
date: 2015-10-26 11:39:16 -0500
comments: true
categories: tvOS
---

![](/images/old-tv.png)

I'm excited for tvOS. I'm excited both as a consumer and as a developer,  particularly because [NSScreencast](http://nsscreencast.com) is a great candidate for a tv app.

I knew I was going to build an app, but there were some choices to make. Should I use the new TVML support for utilizing pre-built templates that you fill with content via XML? Or should I go completely native, utilizing most of what I know with UIKit to build the app?

<!-- more -->

## TVML

While XML sounds like a giant pain, it can sometimes be easy to implement if you have the templates coming from your server. For instance, in a Rails app you can just render tvml as a new content type and template the files with ERB, just like HTML templates.

This gives you tons of flexibility with the content, and you leave the layout & navigation up to the system. You could also deliver new sections of the app, entirely new navigational trees, all without shipping a new version of your app.

I decided against this route ultimately, because I want to ship an app ASAP. I didn't want to be fighting a framework I have only just learned, where documentation is pretty sparse, and where I can't really look to the community for help (yet).

I was also worried that some little requirement I have would mean running into unknown brick walls, causing me to ditch it anyway, and use the native sdk.

Perhaps I will revisit this decision at some point. I expect that hybrid apps are certainly viable, and that might allow you to have a sweet spot of custom functionality with the rapid development with built-in templates.

## Native UIKit

Since tvOS was built upon UIKit, nearly all of UIKit is available to us, and often times you can easily port an app using mostly the same concepts.

There are some differences to note, however:

- Currently tvOS apps run at 1920x1080 resolution (at 1x scale).
- Some TVs have overscan, which means it will crop your interface. You will have to account for some buffer margin around your interface to avoid having things cut off for some televisions.
- There is no UIWebView support, which might be a deal-breaker for some applications.
- There are no "taps". To interact with elements on the screen, they have to be focused first. The focus engine is powerful, smart by default, and customizable. Most tv applications will have to master this concept to build viable applications

Currently the NSScreencast tvOS application is built-upon UITabBarController, UICollectionView, and AVPlayerViewController.

I'm putting some final touches on the application and I hope to submit it to the store to be there on day 1, which will be a first for me.

Now that you can pre-order the tv, the pressure is certainly on!
