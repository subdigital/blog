---
layout: post
title: "Designing a Robust Large File Download System"
date: 2016-09-30 16:45:05 -0500
comments: true
categories: ios
---

{%img center http://benpublic.s3.amazonaws.com/blog/large-file-downloads.png 600 %}

For the [NSScreencast](http://nsscreencast.com) iOS app I wanted to support downloading videos for offline use. With each video being between 80-200 MB in size, this requires some attention to create a download system that is resilient to failure.

<!-- more -->

{%img center http://benpublic.s3.amazonaws.com/blog/large-file-download-1.png 375 %}

The first step was to add a download button that showed progress on the episode screen itself. This is done similar to how you download songs in iTunes. The download button animates into a circular progress indicator. The download happens in the background and sends notifications of progress that the button subscribes to to reflect the overall percentage in the UI.

{%img center http://benpublic.s3.amazonaws.com/blog/large-file-download-progress.gif %}


The actual download is done through an `NSOperation` subclass. Doing it this way offers a number of benefits such as controlling concurrency, quality of service, and having an easy mechanism for cancelling in-flight downloads. Download progress is sent out to the world via notifications that include the episode ID, so any interested piece of UI can intercept these and update.

{%img center http://benpublic.s3.amazonaws.com/blog/operation-queue.png 600 %}

We of course don't need the user to stare at this screen while it downloads, so they are free to move around the app or even suspend it and the download will continue.

Next, I needed a single place to show pending and past downloads to make it easy to see what's being downloaded, watch videos that have been downloaded while offline, and to delete episodes to free up space.

{%img center http://benpublic.s3.amazonaws.com/blog/large-file-downloads-controller.png 375 %}

This screen shows the data in a table view, with a row for each episode. Rows that are currently being downloaded need to get reloaded quickly, as progress notifications fly in.

To accomplish all of this, I decided to save this state as a model in Core Data.  My `DownloadInfo` model looks like this:

{%img center http://benpublic.s3.amazonaws.com/blog/large-file-download-info.png 500 %}

By leveraging Core Data for this, we can track the state of the download throughout its lifecycle. In the past I have used plists, but Core Data has become (dare I say) _easier_ than plists for simple storage.

You can see here that I do store the download progress percentage in the model, but I do not save this repeatedly. On fast connections, you'll get a flurry of these download progress changes (dozens per second) and it is not necessary to save to core data for each one. I only keep this data here in case we cancel the request and want to see this percentage in the UI when a download is no longer in progress.

Another benefit of storing this data in Core Data is that we can take advantage of `NSFetchedResultsController` to quickly build up the `DownloadsViewController`.

## Handling Failure

Any time a network is involved there is a chance for something to go wrong. This chance is exacerbated with large file downloads. People walk out of Wi-Fi coverage, enter tunnels, get on airplanes and plenty of other things that will interfere with the download. To ensure the best possible user experience, I wanted to handle this and allow users to quickly retry (and in some cases, have the retry happen automatically).

When a failure happens, we mark the `DownloadInfo`'s `state` property to `.failed`, and the UI can update accordingly. The cell gets reloaded and the user can tap to retry that download.

## Pausing and Resuming

When the `NSURLSession` API was introduced, they added the ability to cancel a request and produce an opaque object called _resume data_. Using this you can begin a request where it left off, the only question is how you want to persist this data so you can resume it later. This was a perfect fit to add to my `DownloadInfo` model.  When the user taps a download in progress, I call `downloadTask.cancel(byProducing:)` and save the provided resume data to the model for later use.

When a download is started, if the model has some resume data, it is used to resume the request at whatever byte offset they left off at. This feature was easy to add, but can be super useful for large file downloads.

Be careful though, as [resume data is currently broken on iOS 10](http://benscheirman.com/2016/09/resume-data-broken-in-ios-10/).

## Dealing with Cellular

I didn't want to burn up anyone's data plan, so by default the `NSURLSessionConfiguration` has its `allowsCellularAccess` set to false. I then added a setting to toggle this flag, as some people have unlimited plans and might want to use it.

{%img center http://benpublic.s3.amazonaws.com/blog/large-file-downloads-cellular-setting.png 375 %}

Using [FX Reachability](https://github.com/nicklockwood/FXReachability) I monitor the status of the connection. If the user tries to download an episode while we're on cellular I prompt them to toggle the setting and allow the download to continue anyway.

## Keeping the Model and Filesystem in Sync

Since I store metadata about files on disk, I need to make sure that these are always in sync. When you delete a downloaded episode, I have to delete the Core Data model as well as the file on disk. To make sure that these are always in sync, I have a `CleanupDownloadsOperation` that runs on app launch that checks that each saved `DownloadInfo` has a corresponding file on disk (else it gets deleted), and that each file in the downloads folder has a record in Core Data (else it gets removed).

With this in place I have a fallback in case something goes wrong and the two states (db/disk) somehow get out of sync.

## Background Downloads

While seemingly straightforward, background downloads represent a significant source of confusion and complexity, and will be the topic of [my next post](http://benscheirman.com/2016/10/background-downloads).

## Just Add Offline Downloads, They Said

When I first decided to add offline downloads to the app prior to shipping, I figured it would add a day or two of additional work, but it turned out to be surprisingly complex.

Such is software, I suppose.
