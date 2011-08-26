---
layout: post
title: "Vim - Could Not Invoke JSLint"
date: 2011-08-26 08:59
comments: true
categories: vim
---

If you're running MacVim with Janus and have upgraded to Lion, you may
have noticed a little error when you open JavaScript files:

> Error detected while processing function 87_JSLint:
> Line 33:
> could not invoke JSLint!

It seems many are having [this issue](https://github.com/hallettj/jslint.vim/issues/13).  There are 2 things to check:

1. Make sure you have Node in your path.  Confirm this by typing `which
   node` and make sure it resolves a binary somewhere on your system.
2. Open up your `~/.vimrc.local` and add this command:

```vim
    " Use Node.js for JavaScript interpretation
    let $JS_CMD='node'
```

Kudos to [eventualbuddha](http://github.com/eventualbuddha) for
figuring this out.
