--- 
layout: post
title: Incorporating 3rd Party Libraries in iPhone apps
date: 2010-11-2
comments: true
link: false
---
<p>Having my hands in .NET, Rails, and iPhone for the past year I've come to appreciate and loathe the various ways that projects incorporate code from 3rd parties.</p>
<p>Objective-C &amp; Xcode get the award for the least-awesome way of reusing libraries. I'll cut them a tiny bit of slack since this technology is decades old, however it's 2010 and I have work to do. Let's just say there's no "iPhoneGems" project and many projects (such as the excellent <a href="http://allseeing-i.com/ASIHTTPRequest/">ASIHTTPRequest</a>) simply suggest copying over source files into your project. This sucks for a number of reasons, but at the core it's simply copy-paste code reuse.</p>
<h2>No Dynamic Linking</h2>
<p>The reason is mostly because there is no dynamic linking on the iPhone. You can't simply "reference a dll" and have it work. You are limited to static linking, however that means that you need to pre-compile for each SDK version &amp; architecture. Not fun, nor do I even completely understand how all this works. This is how I originally used the <a href="http://code.google.com/p/json-framework/">JSON-Framework</a>, however I've since relegated to copying over source files into my project, after realizing that they hadn't updated their static library for the 4.0 SDK.<br /></p>
<h2>What do the big boys do?</h2>
<p>As a larger example, <a href="http://github.com/facebook/three20">Facebook's Three20 project</a> itself has many projects, and utilizes Xcode's project dependencies. The setup is slightly more involved as you need to setup Header Search Paths, Linker Flags, and other (seemingly arcane) configurations, but if you follow the directions it is not too terrible.<br /></p>
<p>This method sets up project dependencies, where the output of the sub-projects (in this case the suite of Three20's projects) are static libraries for the SDK &amp; Architecture you've specified for your project.</p>
<p>This is a pain to setup initially but does offer some additional benefits, such as having the other projects remain in a separate source tree. In our case, we're pulling in Three20 from a git repository, and we are leveraging git submodules to make this happen. (Though git submodules are a bit of a pain to deal with).</p>
<h2>What do you do?</h2>
<p>Do you utilize this technique for your internal shared code? Or do you resort to copying around source files from project to project?</p>
