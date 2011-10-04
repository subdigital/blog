---
layout: post
title: "Making a UIButton Flip Over"
date: 2011-10-04 08:44
comments: true
categories: iOS
---

If you've used the iPod app on the iPhone, you've probably seen an
interesting trick when switching from album art to the track listing:
the button in the top right corner flips over synchronized with the flip
animation of the main view.

I wanted to achieve a similar effect for the iPhone app that I'm
building, Deli Radio ([app store link](http://itunes.com/apps/deliradio)).

If you've ever struggled with the flip transitions before, you probably
know how finicky it can be to get it all working. The best way to set it
up is to have a parent view contain both views that you want to swap,
and set the animation transition type on _that_ view.

For a button (either in the navigation bar or elsewhere) we'd need to
introduce a parent view to achieve this effect.  This is how I achieved
the effect.

{% img right /images/btn-info-border@2x.png %}
{% img right /images/btn-images@2x.png %}

First, I had two images I wanted to use for my `UIBarButtonItem`.

I wanted this to be easily reusable (since I need to do this in more
than one place in this application), so I created a category method on
`UIButton`.

{% gist 1261810 UIButtonCHButtonFlip.h %}

It may look strange that a `UIButton` class method returns a `UIView`
instance, but we need to have a container view to base the animations
off of.

Here is the implementation:

{% gist 1261810 UIButtonCHButtonFlip.m %}

I am using a little-known technique of setting associated objects
using `objc_setAssociatedObject(...)`.  This uses the runtime to attach
state to an existing class without needing to subclass.

Now that you understand how it is all setup, the block body will now
make sense:

{% gist 1261810 UIButtonCHButtonFlipBlock.m %}

Usage is really easy.  I just created a bar button item with a custom
view, and was done.

```objc
    UIImage *firstImage  = [UIImage imageNamed:@"btn-info.png"];
    UIImage *secondImage = [UIImage imageNamed:@"btn-images.png"];
    UIView *container    = [UIButton flipButtonWithFirstImage:firstImage
                                                  secondImage:secondImage
                                              firstTransition:UIViewAnimationTransitionFlipFromRight
                                             secondTransition:UIViewAnimationTransitionFlipFromLeft
                                               animationCurve:UIViewAnimationCurveEaseInOut
                                                     duration:0.8
                                                       target:self
                                                     selector:@selector(flipContent)];

    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] 
      initWithCustomView:container] autorelease];
```

The effect can be seen below.

{% video /videos/button_flip.m4v 389 336 /videos/button_flip1.jpeg %}

Note that the flip effect on the main view is achieved separately, but
the 2 strategies share identical values for the animation, so the flip
transition types match, as well as the duration & animation curve.

The code for this can be seen in the [ChaiOneUI project on Github](https://github.com/chaione/chaioneui).
