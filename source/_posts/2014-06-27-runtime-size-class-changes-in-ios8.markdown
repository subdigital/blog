---
layout: post
title: Runtime Size Class Changes in iOS 8
date: 2014-06-27 10:06:20 -0500
comments: true
categories: ios8
---

It's been interesting to watch as Apple transitions from hard-coded device sizes, where you only have two real devices to think about (iPhone and iPad), to a more flexible approach that deals with devices of any size.

The hinting of a new potential screen size was so thick you cut it with a knife during WWDC.  The engineers were practically winking at the audience.  When they first announced that you could resize the simulator to "any arbitrary size" there was quite a bit of laughter, because it's obvious that a larger iPhone is coming.

Many of the new APIs that we see in iOS 8 boil down to one thing: **Getting rid of `UI_USER_INTERFACE_IDIOM`**.  _(side note: can you imagine being an engineer in the room when the requirement came in and trying to estimate the ramifications?  What a huge change.)_

This means that there needed to be a way for `UIPopoverController` and `UISplitViewController` to work on iPhone, and allow a single Storyboards to address multiple screen sizes.

But the new APIs don't just support a single code base & interface layout to work on iPhone & iPad, they also allow the screen size to change _at runtime_.

While watching [WWDC Session 228, "A Look Inside Presentation Controllers"](http://developer.apple.com/videos/wwdc/2014) there are a couple of demos that show off changing the simulator size class & dimensions _while the app is running_.

Why is this significant? This hints at a larger change in iOS 8 where you'll be able to do this as a user, being able to display multiple apps on the screen at once.

Indeed there seems to be code in Springboard on iOS 8 that points to this feature.Steve Troughton-Smith [noted this](https://twitter.com/stroughtonsmith/status/476074737081536512) a couple weeks ago:

<blockquote class="twitter-tweet" lang="en"><p>So… just in case there was any doubt left… iOS 8’s SpringBoard has code to run two apps side-by-side. 1/4 size, 1/2 size, or 3/4 size</p>&mdash; Steve T-S (@stroughtonsmith) <a href="https://twitter.com/stroughtonsmith/statuses/476074737081536512">June 9, 2014</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

We are in an interesting time, watching the tea leaves to see where Apple is headed. As an engineer it's very exciting to see how Apple changes their frameworks to support new directions on  iOS.