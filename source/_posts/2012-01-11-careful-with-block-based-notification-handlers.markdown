---
layout: post
title: "Careful With Block-Based Notification Handlers"
date: 2012-01-11 16:27
comments: true
categories: iOS
---

In general, I prefer using block-based APIs over those that accept selectors.

The block based APIs are generally easier to read & follow, and don't clutter up your class with methods that are
out of context with the code that might potentially invoke them.

## An Example

One good example is view animations.  Here we're fading out a view and removing it from the hierarchy once
the view has been completely faded out.  It's concise, easy to read, and you don't need to go anywhere else in the
class to get a complete picture of how this works.

Also, since you can have multiple animations going on, having a block-based completion handler means
you don't have to distinguish between what the animations were in some generic completion method.

``` objc
    [UIView animateWithDuration:0.5 animations:^{
      someView.alpha = 0;
    } completion:^ (BOOL finished) {
      [someView removeFromSuperView];
    }];
```

Contrast this with the non-block version:

``` objc
    - (void)fadeOutView {
      [UIView beginAnimations];
      [UIView setAnimationDuration:0.5];
      [UIView setAnimationDelegate:self];
      [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
      
      someView.alpha = 0;
      
      [UIView commitAnimations];
    }
    
    - (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
      [someView removeFromSuperView];
    }
```

## Block-Based Notification Handlers

`NSNotificationCenter` also got some block love when iOS SDK 4.0 came around.  The old form looked like this:

``` objc
    - (void)setupNotifications {
      [[NSNotificationCenter defaultCenter] addObserver:self
                                               selector:@selector(onWhizBang:)
                                                   name:MyWhizBangnotification
                                                 object:nil];
    }
    
    - (void)onWhizBang:(NSNotification *)notification {
      // reload the table to show the new whiz bangs
      [self.tableView reloadData];
    }
    
    - (void)dealloc {
      [[NSNotificationCenter defaultCenter] removeObserver:self];
      [super dealloc];
    }
```

This isn't a lot of code (and it is easy to remember, unlike the previous UIView animation block code), however
the action and the notification handler are separated from each other.

The block-based API looks like this:

``` objc
    - (void)setupNotifications {
      [[NSNotificationCenter defaultCenter] 
          addObserverForNotificationName:MyWhizBangNotification
                                  object:nil
                                   queue:[NSOperationQueue mainQueue]
                                   block:^(NSNotification *notification) {
                                     //reload the table to show the new whiz bangs
                                     [self.tableView reloadData];
                                   }];
    }

    - (void)dealloc {
      [[NSNotificationCenter defaultCenter] removeObserver:self];
      [super dealloc];
    }
```

Aside from some funky indentation, this is preferable in some cases, especially when the action to
be completed is as simple as reloading the table.

But there's a bug.  Can you spot it?

## Blocks Are Closures

There's a subtle bug here that you might not notice at first.  I didn't realize this until it was littered all
over my code base.

Blocks are [closures][1], and they will capture any values declared outside the scope of the block (and retained) so that
they can be used when the block executes.  This includes variables declared in the enclosing method or any ivars 
that you reference from inside the block.

Here, we used `self.tableView`.  `self` gets retained by the block, which is also retained by self.  We have a *retain-cycle*
which is generally a bad thing.  It's especially bad here, because we don't clear out the block until `dealloc`,
but _dealloc won't ever be called because the block is retaining the instance_!

## Weak Pointers Save the Day

If you've read up on blocks, you've probably seen the `__block` keyword.  This specifier tells blocks not to retain the pointer.
So all we need is a new pointer, like so:

``` objc
    __block MyViewController *weakSelf = self;
    
    // use weakSelf in the blocks, instead of self
```

This sort of code drives me nuts.  It won't be apparent to the next developer why it's there, and it's 
pretty ugly.

## Retain Cycles are Elsewhere, Too

You might also run into this if you have a parent-child view controller relationship, or perhaps a 
an parent->object->delegate chain, where the parent _is_ the delegate.  This is why you typically mark
your delegate property signatures with `assign` instead of `retain` semantics.

Not all retain-cycles are terrible though.  If you have a way of breaking the cycle, then you just need
to weigh how long these objects will remain active for to decide if you need to fix it.

Hopefully this will save you a few headaches down the line.


  [1]:http://simple.wikipedia.org/wiki/Closure_(computer_science)