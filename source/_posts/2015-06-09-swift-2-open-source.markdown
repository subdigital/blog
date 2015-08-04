---
layout: post
title: Swift 2 will be Open Source
date: 2015-06-09 14:18:00 -0700
comments: true
categories: 
---

![](/images/swift-open-source.png)

Apple announced yesterday at WWDC that Swift 2 will be open-sourced later in 2015.  This is fantastic news.  Not only are they releasing the source, but it will be released under a _permissive-license_.

<!-- more -->

> A "permissive" license is simply a non-copyleft open source license — one that guarantees the freedoms to use, modify, and redistribute, but that permits proprietary derivative works. See the copyleft entry for more information.

> [opensource.org](http://opensource.org/faq#permissive)

This means you can take Swift and do whatever you want with it. Swift on Android. Swift on Windows. Swift on the server. Swift as a systems language. Swift anywhere. Everywhere.

## Swift on Linux

Apple also announced that they will port Swift to Linux.  It's not clear if this will happen in 2015, or shortly thereafter, but it is clear that they are committed to make this happen.

*2016 will be the year of Swift on the server.*

By being open source, I fully expect to see web frameworks arise, akin to Sinatra or Rails, that allow you to use Swift to write web applications. This appears to be an incredibly powerful concept, but there are still a lot of questions:

- How fast is Swift? How does it hold up to Go, Python, Ruby, Scala, and other popular server language choices
- Will CocoaPods and/or Carthage still be appropriate for managing dependencies and 3rd party libraries?

## What about Foundation?

The Swift standard library will be included, which includes things like `String`, `Dictionary`, `Array`, etc, but Foundation is actually Objective-C and will not be included.

This is somewhat of a disappointment, because it could be incredibly powerful to use classes like `NSLinguisticTagger`, `NSDateComponents` and `NSCalendar`, or other frameworks like `NSURLSession` and the like. Even Core Data, if that's your kind of thing.

This means that there will be more of a need than before to develop and embrace reusable open-source libraries that offer the functionality we will inevitably need.

It's an exciting time.  The Swift 2 changes are very well thought out, and I'm confident that the Swift engineers are not only bright, capable folks, but they are clearly listening to the community and taking Swift in a good direction.
