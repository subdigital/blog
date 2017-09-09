---
layout: post
title: "The Effect of Primetime Media Coverage"
date: 2017-03-06 17:22:52 -0600
comments: true
categories: ios
---

<p style="text-align: center">
<img src="http://benpublic.s3.amazonaws.com/blog/5calls-primetime/msnbc-5calls.png" style="width: 300px;">
</p>

In [my last post](http://benscheirman.com/2017/02/5-calls/) I talked about how I helped launch the [5 Calls](https://5calls.org) iOS app.

Shortly after this hit the store, Michael Moore (yes, _that_ Michael Moore) posted on Facebook, and his website, a [10 Point Plan](http://michaelmoore.com/10PointPlan/) to stop Trump. In the article, he mentioned 5 Calls specifically as an easy way to get in touch with your representatives.

> Here’s some great news&#58; Someone has created an app to make this very easy: Go to the App Store and get “5 Calls”. The app will dial the friggin’ phone for you and give you talking points for when you speak to your reps!

Later on that week, he was invited to Chris Hayes’ show on MSNBC. Sure enough, **he ended up giving an enthusiastic overview of the app on national TV during prime time**.

<!-- more -->

Here’s the spot, in case you missed it:

<iframe width="640" height="360" src="https://www.youtube.com/embed/0t-s4XNi3ms" frameborder="0" allowfullscreen style="margin-bottom: 10px"></iframe>

I immediately noticed the increased traffic, thanks to Fabric’s realtime analytics. I was watching as the active user count jump from the usual 50-100 to over 5,000 active users. The active user count peaked at around 7,500 users. That is a an insane amount of realtime usage, and unlike anything I have worked on before.

<p style="text-align: center">
<img alt="fabric active users" src="http://benpublic.s3.amazonaws.com/blog/5calls-primetime/fabric-active-users.gif" style="max-width: 400px; width: 100%">
</p>

During this time, the web app (which is written in Go) was handling the traffic just fine, but one of our partner APIs (Google’s Civic API that provides representative information) rate-limited us, cause many of the requests to fail. Luckily this was resolved fairly quickly.  _(Side note: it is so liberating to be part of a team that had the server part completely covered. Usually that's my job also!)_

Eventually the surge subsided a bit and we were given a bit of a reprieve. 

The net result of this coverage was **nearly 40 thousand new users** (analytics reset at midnight UTC making the number split between two days in the chart).


<p style="text-align: center">
<img src="http://benpublic.s3.amazonaws.com/blog/5calls-primetime/downloads-chart.png" style="width: 100%; border: solid 1px #eee;" alt="downloads chart">
</p>

**It also made it into the top charts at #3 for the Reference category, and #143 overall.** I'm not sure what it would take to supplant the Bible app as the number 2 spot, but we were not able to crack it.

<p style="text-align: center">
<img src="http://benpublic.s3.amazonaws.com/blog/5calls-primetime/top-reference.jpg" alt="top reference apps" style="text-align: center; max-width: 188px; width: 100%;">
</p>

It was pretty surreal to see all this take place. People from way outside my normal circles were using and sharing an app I worked on. It appealed to a _huge_ market. Ultimately this means the 5 Calls app was _way_ more successful than I had hoped for, and resulted in _many thousands_ of calls to Washington, continuing every day.

And that is something to be proud of.