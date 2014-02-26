---
layout: post
title: "Fixing GitHub SSL Issue on 10.9.2"
date: 2014-02-26 09:36
comments: true
categories: 
---

By now you've most likely heard about the [egregious SSL flaw](http://arstechnica.com/security/2014/02/extremely-critical-crypto-flaw-in-ios-may-also-affect-fully-patched-macs/) that has existed in OSX and iOS for a while now.

Yesterday, Apple (finally) released 10.9.2 which addressed the flaw, as well as some other features.  Upon upgrading, I was 
more than slightly frightened to see this error when trying to open [github.com](github.com):

![](https://benpublic.s3.amazonaws.com/blog/github-ssl.png)

Had I been compromised already?  I didn't see any other reports of this yesterday, so I just closed my laptop and hoped
that a reboot fixed it.

On a suggestion from a [coworker](https://twitter.com/yujingzheng) I reset my keychain and the SSL problem disappeared.  To
do this, launch **Keychain Access**, then open **Preferences**.  Click on **Reset My Default Keychain**.  

![](http://monosnap.com/image/5Y3itWVYvD5Fg6tptqMHUymer5H60i.png)

This is a gigantic pain in the ass, but it does fix the problem.  Your old keychain will be backed up and 
stored in your Keychains folder.

I'm still unsure why the update caused this issue for only some of us, but hopefully this will help those of
you who are experienced this issue.
