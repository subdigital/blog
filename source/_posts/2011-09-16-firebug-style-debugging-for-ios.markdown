---
layout: post
title: "Firebug-Style Visual Debugging for iOS"
date: 2011-09-16 10:56
comments: true
categories: iOS
---

Using a crazy helpful library called [DC Introspect](https://github.com/domesticcatsoftware/DCIntrospect) you're able to easily take an app running in the Simulator:

{% img image /images/simulator-before-introspection.png %}

And get visual frame debugging information like this:

{% img image /images/simulator-after-introspection.png %}

You can also click & drag your mouse to get pixel information,
surrounding frames, print out detailed frame information in the console,
and even move frames around all while the app is running.

Using it is incredibly simple:

* Make sure you have `DEBUG` defined in your Preprocessor Macros:

{% img image /images/debug-preprocessor-macro.png %}

* Download the code from https://github.com/domesticcatsoftware/DCIntrospect and drag the DCIntrospect/DCIntrospect folder into your project

* In your Application Delegate class, make the following changes:

```objc

    #import "DCIntrospect.h"

```

```objc
    // in applicationDidFinishLaunching:

    [self.window makeKeyAndVisible];

    #ifdef TARGET_IPHONE_SIMULATOR
        [[DCIntrospect sharedIntrospector] start];
    #endif

```

Once that is done, the library will be loaded and you can use it.  When
the simulator launches, just press Spacebar to activate the tool.

Here are some keyboard shortcuts:

- `o` - Outline all views
- `?` - Prints out a help view
- `f` - Flash on `drawRect:` calls
- `c` - Toggle showing coordinates
- `4 6 8 2` - Nudge the selected view left, right, up, down
- `0` - Recenter view where it was originally
- `9 7 3 1` - Modify Width & Height of selected view

You can also click & drag with the mouse to get detailed information
about frames & mouse position.

I am amazed at how awesome this library is. I'll be using it in my
default toolbox from now on.
