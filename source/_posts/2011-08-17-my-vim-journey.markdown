---
layout: post
title: "My Vim Journey"
date: 2011-08-17 23:53
comments: true
categories: vim
---

For my Rails work, I've largely leaned on [TextMate](http://macromates.org).  It's used by many Rubyists, looks sexy,
and is easily extended.

I still use TextMate frequently, but I've been ramping up on my Vim
skills and I've recently come to a point where I think I'm pretty
productive in it.

My initial frustrations with Vim were that it was too configurable.
Talk to any Vim power-user and you'll find a completely different set of
plugins & keyboard shortcuts.  If you snag a friend's set of Vim
configuration files (like I did) you might find yourself frustrated that
there's too much to learn and it's difficult to know where various
behaviors are coming from.

In this post, I'll attempt to demonstrate a very sane Vim setup that
newcomers can use to get started and not be too overwhelmed.

## Why Vim?

Before I get started with the basics of Vim, why would you use it in the
first place?

For me it boils down to this:  _I love staying on the keyboard_.
Vim may not make you faster (_in fact initially you'll be a lot slower_) but it can fit your workflow better.

Another big differentiator of Vim is _Command Mode_.  The notion
here is that you spend more time wrangling text rather than creating it
from scratch.  That's certainly true of my code.

It is important, however, that in the larger software ecosystem,
*typing is not the bottleneck*.  Don't expect Vim to make you build
the right software faster.

Vim enables a keyboard-optimized workflow that _may_ make you faster.
YMMV.  If you're fast with TextMate or Emacs or don't want to spend the
time to learn something new, then Vim may very well not be for you.

Lastly, Vim is ubiquitous.  It's on every platform and
you can carry your configuration (or a very large set of it) everywhere.
People frequently put their vim configurations on Github for themselves
and others to utilize.

## Getting MacVim

Almost all Unix-based systems (like Mac) include a terminal version of
Vim.  The version included on OS X isn't compiled with Ruby support, so
some plugins won't work.  In addition, it doesn't have OS-level
integration like Copy & Paste in the same buffer.

Most Vim users I know use MacVim, which comes pre-compiled with Ruby
support, has tabs, and more.

If you have [homebrew](http://mxcl.github.com/homebrew/) installed, just
type:

```
brew install  macvim
```

If you'd rather grab a pre-built binary, then head on over [here](https://github.com/b4winckler/macvim).

You'll also want to make sure that the `mvim` binary is in your path.

## Basic Vim Navigation

I won't cover everything you can do in Vim here, but here's just enough
to get you started:

In Command Mode:

- Press `h`, `j`, `k`, `l` to move the cursor around.  It will feel weird, but you start to appreciate not 
  lifting your hand off of the home row to reach for the arrow keys.
- Press `gg` to go to the end of a document, `G` to go to the top of
  the document.
- Press `i` to go to insert mode at the current position
- Press `a` to "append" content at the end of the current line
- Type `cw` ("change word") to replace the current word and go into
  insert mode
- Type `dta` to ("delete 'til the letter a") in a line

In Insert Mode:

- Press `esc` to go back to command mode.

Commands:

- In Command Mode, you can type commands by prefixing them with `:`.
- To write the changes to the current buffer (save) type `:w` and hit
  `enter`.  Often times you'll write & quit in one command, with `:wq`.

Feel free to use the mouse & arrow-keys while you're getting used to everything.  It
will feel weird.

For more Vim-fu, definitely check out this [PeepCode
screencast](http://peepcode.com/products/smash-into-vim-i).

## Installing a Base Set of Plugins with Janus

The real power of Vim is in the plugins, and fortunately Yehuda Katz &
Carl Lerche have put together an opinionated and useful set of plugins
that are pre-configured and work well together.  Take a look at the plugins it includes
[here](https://github.com/carlhuda/janus).

Getting Janus installed is easy.  If you are super trust-worthy and
don't mind running a script blindly (I don't recommend it) you can
simply run:

```
curl https://raw.github.com/carlhuda/janus/master/bootstrap.sh -o - | sh
```

More explicit instructions for the paranoid can be found on [the github
page](http://github.com/carlhuda/janus).

Once you have Janus installed, your Vim will be on steroids. Don't worry
though, I'll try to cover the most important things you'll be using.


## Getting a Decent Theme installed

MacVim installs a hundred nasty looking themes, but a few of them are
worth taking a look at.  Here are some that I like:

- molokai
- railscasts
- vividchalk
- vibrantink

If you want to install other themes (like this nice [github](http://www.vim.org/scripts/script.php?script_id=2855) one) then you
simply download it & copy the `theme.vim` (or whatever the theme is
called) to `~/.vim/colors`.

To switch between the themes that are installed, you can use the menu,
or you can type `:colorscheme <scheme>`.

To set defaults for your installation, you'd normally add commands to
`~/.vimrc` however Janus has taken that file over.  It instead reads
your settings from `~/.vimrc.local`.  In order to provide settings for
graphical Vim installations (like MacVim) there's also a `~/.gvimrc`
file.

Open up that file (`:edit ~/.gvimrc`) and add the following commands:

``` vim
    colorscheme github
    set guifont=Menlo:h14
```

Feel free to tweak this to contain your favorite color scheme & font.
In order to see these changes you have to "source" the file:

```
    :source %
```

(`%` here means "current file")

You should see the changes take effect immediately.


## Opening MacVim with a "Project"

One common thing in TextMate is to `cd` into a project and then type
`mate .` which will open TextMate's project drawer with all of the files
in that directory loaded up.

In MacVim, you can do the same.  Navigate to a folder with some content
(like a Rails app) and type: `mvim .`

You should see something resembling a file navigator.  You can navigate
these with the same movement commands from above.

Once you've chosen a file, press `enter` to open it in the buffer.

{% pullquote %}
Janus comes with NERDTree, which has similar behavior to TextMate's
Project Drawer.  Open up the NERDTree pane by typing `<leader>-n` or `\n`. By default the leader key is set to backslash.
{" The leader key is a special, configurable key used to create quick shortcut combinations."}
{% endpullquote %}

The NERDTree window can be collapsed by typing `<leader>-n` again.

You might want to instead find the file by searching for it by name.
For that, the aptly-named Command-T plugin can be hepful.

Command-T can be activated (by default) with `<leader>-t`.  Start typing
and it will auto complete the results.

## Scared Yet?

Writing this reminds me of how hard it was to get started.  I can only
offer some encouragement that with practice, Vim does start to feel like
 you can leverage your fast typing skills to really.

Practice only a couple of commands at a time.  Really learn what they
are doing and then move one to the next command.  Print out a cheet
sheet.  Pair with someone else who uses Vim.

I hope you found this intro useful. I'll cover some more Vim tricks as time goes on.
