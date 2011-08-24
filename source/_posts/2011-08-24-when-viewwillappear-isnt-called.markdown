---
layout: post
title: "When viewWillAppear: Isn't Called"
date: 2011-08-24 10:11
comments: true
categories: iOS
---

The `UIViewController` lifecycle is pretty simple.  `viewDidLoad` is
called when the view is loaded (usually from a XIB) and when the view
controller's view is about to be displayed `viewWillAppear:` gets called
(and `viewWillDisappear:` when it goes away).

The problem is, when you have a non-standard view hierarchy (like my
current app) these methods don't get called. The Apple docs have this to
say about the problem:

> Warning: If the view belonging to a view controller is added to a view hierarchy directly, the view controller will not receive this message. If you insert or add a view to the view hierarchy, and it has a view controller, you should send the associated view controller this message directly. Failing to send the view controller this message will prevent any associated animation from being displayed.

In my application I have a persistent bar at the bottom of the screen,
so my `UINavigationController` only owns a portion of the screen.  Thus, my
`RootViewController` (which owns these 2 portions) is always _active_.

{% img screenshot /images/non-standard-nav-frame.png %}

I recently came upon a requirement that needed to leverage
`viewWillAppear:` and `viewWillDisappear:` in order to decorate the
bottom bar with some additional information. Since this is a view
controller a few layers deep in the hierarchy, the methods weren't being
called.

Luckly, there is a fix to this. The navigation controller can notify
its `delegate` when it changes view controllers.

Start off in the view controller that is the root of the navigation
controller hierarchy.  Make it conform to the
`UINavigationControllerDelegate` protocol.  We'll also need an ivar to
store the last view controller that _appeared_ so that we can notify
when it _disappears_.

```objc
    @interface MyRootViewController : UIViewController
        <UINavigationControllerDelegate> {
          UIViewController *_lastViewController;
    }
    // methods

    @end
```

In the implementation, in do the following:

```objc

    @implementation MyRootViewController

    // other stuff

    - (void)viewDidLoad {
        [super viewDidLoad];

        self.navigationController.delegate = self;
        // ...
    }

    - (void)navigationController:(UINavigationController *)navigationController 
          willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
        if (_lastViewController) {
            [_lastViewController viewWillDisappear:animated];
        }

        [viewController viewWillAppear:animated];
        _lastViewController = viewController;
    }

```

If you need support for `viewDidAppear` and `viewDidDisappear` then
you'd have to implement this method as well:

```objc
    - (void)navigationController:(UINavigationController *)navigationController 
           didShowViewController:(UIViewController *)viewController 
                        animated:(BOOL)animated;
```

After doing this, your view controllers should start receiving the
`viewWillAppear:` and `viewWillDisappear:` methods successfully.


