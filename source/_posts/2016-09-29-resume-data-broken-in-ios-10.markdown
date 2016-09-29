---
layout: post
title: "Resume Data Broken in iOS 10"
date: 2016-09-29 09:58:25 -0400
comments: true
categories: ios
---

Downloading large files on iOS is straight forward. You configure a `URLSession` with a `URLSessionConfiguration`, create a `URLSessionDownloadTask` with the URL that you want to download, and then call `.resume()` on it.

Later on, during the transfer, if you want to pause this request (or cancel it), you call `cancel(byProducingResumeData:)` and pass a block to it.  This block yields to you what is called "resume data". The docs describe it like this:

> A data object that provides the data necessary to resume a download.

It is an opaque object of type `Data` that we're not really supposed to be concerned about, except that:

1. It is easily serializable, so it can be stored on disk or CoreData
2. You pass this same object back to a new download task to resume the download

## The Problem

While building the [NSScreencast](http://nsscreencast.com) iOS app I ran into an issue with resume data that wasn't present on iOS 9. When using a _background_ session configuration, resuming a request would crash instantly. The crash produced an interesting tidbit in the logs:

> 2016-09-25 09:37:45.804 ResumeBroken[25194:3786786] *** -[NSKeyedUnarchiver initForReadingWithData:]: data is NULL
> 2016-09-25 09:37:45.805 ResumeBroken[25194:3786786] *** -[NSKeyedUnarchiver initForReadingWithData:]: data is NULL
> 2016-09-25 09:37:45.805 ResumeBroken[25194:3786786] Invalid resume data for background download. Background downloads must use http or https and must download to an accessible file.
> Download error: Error Domain=NSURLErrorDomain Code=-3003 "(null)"

Looking at the above, it seems as if iOS was using `NSKeyedUnarchiver` on our provided resume data with a null data parameter. Knowing that our actual resume data was not null, it appeared that this was something internal to the resume data structure.

The same setup with a _default_ session configuration **did not** exhibit this problem.

As it turns out, `resumeData` itself is actually a property list made up of the following keys:

- `NSURLSessionDownloadURL`
- `NSURLSessionResumeBytesReceived`
- `NSURLSessionResumeCurrentRequest`
- `NSURLSessionResumeEntityTag`
- `NSURLSessionResumeInfoTempFileName`
- `NSURLSessionResumeInfoVersion`
- `NSURLSessionResumeOriginalRequest`
- `NSURLSessionResumeServerDownloadDate`

## The Workaround

Doing a little digging, I found [this post](http://stackoverflow.com/questions/39346231/resume-nsurlsession-on-ios10) on Stack Overflow that provided a description of the issue and an (admittedly gross) workaround.

> This problem arose from currentRequest and originalRequest NSKeyArchived encoded with an unusual root of "NSKeyedArchiveRootObjectKey" instead of NSKeyedArchiveRootObjectKey constant which is "root" literally and some other misbehaves in encoding process of NSURL(Mutable)Request.

In the case of the background session configuration, The `NSURLSessionResumeOriginalRequest` and `NSURLSessionResumeCurrentRequest` fields contained an invalid root object key, and thus couldn't be parsed property, producing the error shown above.


The [actual workaround](http://stackoverflow.com/a/39347461/3381) is not pretty, but does work, which involves detecting and _rewriting_ the resume data property list to match what the URLSession system is expecting.

I have filed a radar about this ([28542420](rdar://28542420)).