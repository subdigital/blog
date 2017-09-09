---
layout: post
title: Nibs are Cool Again
date: 2016-02-04 07:55:13 -0600
comments: true
categories: ios
---

I’m working on a client project that has a pretty large legacy codebase. For some new features I’m working inside of an existing architecture, so I’m using a _when-in-rome_ strategy for implementing new features. In other words, how I implement something may be different than if this were a greenfield project.

For instance, the existing application is written in Objective-C. While I would likely write the application in Swift if I were starting over, it makes total sense to continue the application in Objective-C for the short term.

<!-- more -->

This project also doesn’t use Storyboards or Autolayout. In fact, most of the views are laid out manually. When done well, this isn’t as scary as it sounds (which isn’t the case).

So when I needed to implement a complex collection view, I created nibs for each custom cell and supplementary view so I could take advantage of the designer. I also was able to use auto layout just for these views without turning it for the entire application.

It is surprising how fast Interface Builder can be  with plain nibs in comparison to Storyboards. I used Storyboards for the [NSScreencast tvOS application][1], and that has been a constant source of frustration. It’s slow (even on a 5k iMac) and on my 12” MacBook it’s sort of comical how large everything is.

Storyboards do have some compelling advantages:

- You can do static table views
- You can prototype rather quickly
- You can design your segues between view controllers
- You can leverage size classes

But most of this stuff stops helping you and starts becoming a nuisance at some point or another.

Say you want a static table view, but you want to use your own view controller? Or what if you want to mix static & dynamic content? Too bad, you can’t.

Say you want to re-use the same view controller in multiple places in your application?  Storyboards has no real way of making this work, so you have to drop to code.

Say you want to provide some data to the next view controller (which is basically *90% of the segues you’ll create*), guess what you have to drop to code again and implement `prepareForSegue:`.

I’m not advocating for doing _everything_ in a designer. But the constant flip-flop between what you can do in the designer and what you must do in code adds friction to the process. I’m finding that nibs strike this balance a bit more comfortably to me. They don’t pretend to do anything other than layout views. The rest is up to you anyway.

### Side note about size classes

On this project I’m lucky to be constrained to just iPhone in portrait mode.  If I had to support rotation and larger screen sizes, then I might bemoan the lack of size class support in nibs. Or I’d just do it all in code 😏.

[1]:	http://benscheirman.com/2015/10/say-hello-to-nsscreencast-tv/