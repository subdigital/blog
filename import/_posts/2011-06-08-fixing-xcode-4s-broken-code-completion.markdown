--- 
layout: post
title: Fixing Xcode 4's Broken Code Completion
date: 2011-6-8
comments: true
link: false
---
<p>In my continued quest to actually use Xcode 4 full time, I've run into yet another major issue: Xcode 4's code index sometimes gets borked and syntax highlighting &amp; code completion stop working.</p>
<p>In the past, this has been fixed (temporarily) by deleting the Derived Data folder in Organizer, restarting Xcode, changing the compiler from LLVM to GCC &amp; back again or some random combination of the 3. This doesn't always work, and today I sat down to figure out what the cause was and how to fix it.</p>
<p>In searching stackoverflow and the developer forums, I found that Xcode's code index can hang on recursive and/or relative search paths.</p>
<p>My project utilizes 2 static libraries, so I must provide proper header search paths, otherwise the compiler doesn't recognize any of the symbols.</p>
<p>So if you have a Header Search Path setting of <strong>`../lib/MyAwesomeLib`</strong> or <strong>`../lib/MyAwesomeLib/**`</strong> then you might be having this problem too.</p>
<h2>Step 1: Correcting relative paths</h2>You might be tempted to hard code the path to the file. Don't! This will break on somebody else's machine, and most of the time you're not working on this stuff alone.<br />
You can utilize the $(SOURCE_ROOT) build variable to construct a dynamic path relative to the Xcode project directory.<br />
This step might be all you need, but in my case I needed to follow the next step as well...<br />
<h2>Step 2: Remove the need for recursive searches</h2>I have two subprojects, each of which symlink their build output to a build/current folder. This makes it easy to add a non-recursive library search path reference for similar reasons. I also want to copy headers into this folder so there's always a deterministic location to find the headers, regardless of the platform &amp; configuration we're building for.<br />
So I added a Run Script build phase to do this work for me:<br />
{% codeblock lang:shell %}
# Symlink build output to a common directory for easy referencing in other projects
rm -rf "$BUILD_DIR/current"
ln -s "$BUILT_PRODUCTS_DIR" "$BUILD_DIR/current"

# Copy headers to a shared location
mkdir -p "$BUILD_DIR/current/headers"
for file in `find . -name "*.h"`; do cp $file "$BUILD_DIR/current/headers/"; done;
{% endcodeblock %}The line is a bash for loop that copies all the header files in any subfolder &amp; flattens it out for a single headers folder reference.<br />
<h2>Step 3: Add the new common header search paths</h2>In my case I exchanged a relative, recursive search path of:<br />
{% codeblock %}
../lib/**
{% endcodeblock %}<br />
to the more explicit, and more Xcode 4 friendly:<br />
<br />
<img src="/images/Xcode4_.png"  alt="Xcode.png"  /><br />
As soon as I did that, my code lit up like a Christmas tree! Symbols were recognized, code was highlighted, and best of all... code completion resumed.<br />
Here's to hoping the Xcode 4 continues to be improved. In the meantime, hope this fix saves you the headache I've been having.
