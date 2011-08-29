--- 
layout: post
title: Creating Proper IPA Files in Xcode 4
date: 2011-6-2
comments: true
link: false
---
<p>Xcode 4 has changed a lot of things. Most of those things are ok, but occasionally I find that I just cannot do something any other way than to use Xcode 3.</p>
<p>Until today, I was creating Ad-hoc builds for my current project with Xcode 3, then selecting Share &amp; saving the resulting IPA file to disk.</p>
<p>Xcode 4 has the new "Build -&gt; Archive" menu option, but every time I'd try to share this file, I'd presented with this lovely restricted dialog box:</p>
<p><br />
<img src="/images/Xcode3.png"  alt="Xcode.png"  /></p>
<p>With the errors <i><b>No Packager exists for the type of archive</b></i> and <i><b>This kind of archive cannot be signed</b></i>.</p>
<p>As it turns out, if you have static libraries that you're linking in, your Archive step actually outputs those as well. Xcode doesn't know how to create an IPA out of 1 .app file and a handful of .a files, so it gives up.</p>
<p>You can tell that Xcode 4 is doing this if your Organizer -&gt; Applications list shows an icon like this:</p>
<p><br />
<img src="/images/Xcode2.png"  alt="Xcode.png"  /></p>
<p>If you right-click on this build, and select "Reveal in Finder" you'll see the files are .xcarchive files. Right click on that and select "Show Package Contents" to see what I'm talking about. If you see a usr/lib/mystaticlibary.a file, then read on for the fix.</p>
<p>You need to tell Xcode 4 <b>not</b> to "install" the static libraries. For each of the static library targets, select them in Xcode 4, and under Build Settings, search for "Skip Install". Set that flag to YES. I had to do this to both of the static libraries I include in my project.</p>
<p><img src="/images/Xcode1.png"  alt="Xcode1.png"  /></p>
<p>Once that's done, your app should show a normal icon again &amp; have the ability to export to IPA just like before. Yay!</p>
<p><br />
<img src="/images/Xcode.png"  alt="Xcode.png"  /></p>
<p>Huge thanks to <a href="http://stackoverflow.com/questions/5265292/xcode-4-create-ipa-file-instead-of-xcarchive">this stackoverflow question</a> for pointing me in the right direction.</p>
