---
layout: post
title: "Quick Look Debugging with UIView"
date: 2014-03-14 10:45
comments: true
categories: iOS
---

Xcode 5.1 was released the other day and with it we got a [bunch of new features](http://9to5mac.com/2014/03/10/xcode-5-1-iad-producer-4-1-2-released-with-improved-ios-7-1-compatibility/)
including Quick Look Debugging for custom objects.  I covered this briefly on
[NSScreencast episode 111](http://www.nsscreencast.com/episodes/111-xcode-5-1).


As long as you can distill your object into one of the [supported types](https://developer.apple.com/library/mac/documentation/IDEs/Conceptual/CustomClassDisplay_in_QuickLook/CH02-std_objects_support/CH02-std_objects_support.html#//apple_ref/doc/uid/TP40014001-CH3-SW1),
you can provide a visualization for your own objects.

![quick look of a CLLocation](https://benpublic.s3.amazonaws.com/blog/debug-location.png)

<!-- more -->

No matter that the class is `PhoneNumber`, to demonstrate the feature I just implemented the
method by returning a `CLLocation *`.

`UIView` is also supported, however it seems to be limited to `UIViewController`'s
`view` property.

![quick look of a custom view](https://benpublic.s3.amazonaws.com/blog/debug-view-controller-view.png)

You might notice that if you just have a variable of a `UIView` that you
can't take advantage of this.  Instead, you'll get this message:

![quick look view failure](https://benpublic.s3.amazonaws.com/blog/debug-view-fail.png)

My suspicion is that this is because the `- debugQuickLookObject` method is implemented
on a category method that is included by `UIViewController`.  I'm not entirely sure
if this is the case, but we _can_ create our own category method to provide the same behavior.

```objc
#import "UIView+DebugObject.h"

@implementation UIView (DebugObject)

- (id)debugQuickLookObject {
    UIGraphicsBeginImageContext(self.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end

```

Once that's done, I just include the category method header in my view controller,
and quick look debugging of view _variables_ now works:

![quick look of a view variable](https://benpublic.s3.amazonaws.com/blog/debug-view.png)
