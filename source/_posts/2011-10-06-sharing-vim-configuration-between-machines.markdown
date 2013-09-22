---
layout: post
title: "Sharing Vim Configuration Between Machines"
date: 2011-10-06 09:29
comments: true
categories: vim
---

I do most of my development on my MacBook Pro, however I have a nice 27"
iMac at home, and it is refreshing to use it for development when I can.
It's fast and has a huge screen.  The only downside is all my custom
development configurations are on my MacBook Pro!

There are a number of options you can use to share settings between
machines, but I'm a fan of using [Dropbox](http://dropbox.com) ([referral link](http://db.tt/sYjPEQl)). Any change I make, on either machine, will get automatically
synchronized for me.

Since my Vim configurations were already present on my MacBook Pro, the
first step was to copy them over to a Dropbox folder:

```
    mkdir ~/Dropbox/vim
    cp -R ~/.vim ~/Dropbox/vim
    cp ~/.vimrc ~/Dropbox/vim
    cp ~/.vimrc.local ~/Dropbox/vim
    cp ~/.gvimrc ~/Dropbox/vim
```

The next step was to come up with an installer script that would symlink
these files on a new machine.  I made sure to move existing vim files to
a temporary filename so that I wouldn't lose anything accidentally.

```bash
    set -o errexit

    function confirm()
    {
        echo -n "$@ "
        read -e answer
        for response in y Y yes YES Yes Sure sure SURE OK ok Ok
        do
            if [ "_$answer" == "_$response" ]
            then
                return 0
            fi
        done

        # Any answer other than the list above is considerred a "no" answer
        return 1
    }

    function link_file() 
    {
      echo "symlinking $1"
      ln -s "$PWD/$1" "$HOME/$1"
    }

    echo "This will remove any existing vim configuration files and simlink them with the files here."
    confirm "Are you sure?"
    if [ $? -eq 0 ]
    then
      for file in ~/.vimrc ~/.vimrc.local ~/.gvimrc
      do
        if [[ -f $file ]]; then
          echo "Moving $file to $file.bak"
          mv $file $file.bak
        fi
      done

      for dir in ~/.vim
      do
        if [[ -d $dir ]]; then
          echo "Moving $dir directory to $dir.bak"
          mv $dir $dir.bak
        fi
      done
    fi

    echo "symlinking"

    for file in .vim .vimrc .vimrc.local .gvimrc
    do
      link_file $file
    done

    echo "Done.  Check that it works.  If so, you can remove the .bak files, if any"

```

Make sure the script is executable by running:

```
    chmod +x setup.sh
```

Then run this script on any new machine that you want to use Vim on. It will symlink these files from your Dropbox folder to your home
folder:

  - `.vim/`
  - `.vimrc`
  - `.vimrc.local`
  - `.gvimrc`

After it's done, check that it is working.  Remove any .bak files that
you don't need anymore.

And that's it. You have an automatic Vim configuration synching system
between machines.  It works great for your shell configuration as well!
