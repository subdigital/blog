---
layout: post
title: "Creating a Glow Effect for UILabel and UIButton"
date: 2011-09-27 19:57
comments: true
categories: iOS
---

One recent iPhone design mockup called for a glowing effect for a
`UIButton`.

This can be accomplished with images, however I needed a series of
buttons to have the same glow effect, and it can easily be accomplished
with Core Graphics.

The first step is to include the Core Graphics headers:

```objc
    #import <QuartzCore/QuartzCore.h>
```

Next, the effect is achieved by using a shadow with no offset (meaning
the shadow will be directly underneath the text, not shifted down or to
the right).  The layer is then given a shadow radius & opacity to allow
the shadow to bleed outward.  Unsetting `masksToBounds` will allow the
glow to be drawn even outside of the label's frame. Finally the shadow color is set to either the
foreground color or something a bit lighter.

```objc
    UIColor *color = button.currentTitleColor;
    button.titleLabel.layer.shadowColor = [color CGColor];
    button.titleLabel.layer.shadowRadius = 4.0f;
    button.titleLabel.layer.shadowOpacity = .9;
    button.titleLabel.layer.shadowOffset = CGSizeZero;
    button.titleLabel.layer.masksToBounds = NO;
```

This effect works on plain `UILabel` or the `titleLabel` property of a
`UIButton`.  You can see the results of the effect here:

{% img image /images/uibutton-gloweffect.png %}

Don't go overboard with this.  It's a subtle effect, but looks great
when used effectively.
