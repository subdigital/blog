---
layout: post
title: "Synchronizing dotfiles"
date: 2013-12-20 10:22
comments: true
categories: 
---

I'd put this off for far too long, but I finally released my [dotfiles on Github](https://github.com/subdigital/dotfiles).  Part of the reason it took me a while is I already had a syncing solution in Dropbox.  I'm still using Dropbox to synchronize between my own machines, but I now have them published on Github as well.  In addition, I wrote a handy script (with some inspiration from [Steve Harman's dotfile setup](https://github.com/stevenharman/config/blob/master/Rakefile)) that symlinks the files into the right spot on the target machine:

```ruby
require 'rubygems'
require 'rake'
require 'colored'

desc "Create symlinks for each of the files.  Prompts before overwriting"
task :symlink do
  create_symlinks
end

def all_files
  Dir.glob('.*')
end

def ignore_files
  [ '.git', '.gitignore', '.', '..' ]
end

def create_symlinks
  dir = File.dirname(__FILE__)

  (all_files - ignore_files).each do |file|
    homedir = File.expand_path ENV['HOME']
    source_path = File.join dir, file
    target_path = File.join homedir, file
    if File.exists?(target_path)
      puts "File #{target_path} exists.  Overwrite it (y/n)?"
      if STDIN.gets.chomp.downcase == 'y'
        puts "#{"DELETING".red} #{target_path}"
        raise "This shouldn't happen, but if it does, I'm refusing to delete /" if target_path == "/"
        FileUtils.rm_r(target_path)
      else
        puts "#{"SKIPPING".blue} #{target_path}"
        next
      end
    end

    puts "#{"[SYMLINK]".green} #{source_path} --> #{target_path.yellow}"
    FileUtils.ln_s(source_path, target_path)
  end

  puts
  puts "Done."
end
```

With this script it will prompt before deleting files that already exist in your home folder. If you haven't used the [colored](http://rubygems.org/gems/colored) gem before, it's super easy to use and can help make your script output more readable.

## Vim plugins

Another roadblock to getting my entire `.vim` folder in a git repository is that I use [pathogen](https://github.com/tpope/vim-pathogen) to easily manage vim plugins.  The way pathogen works is each plugin is cloned into `.vim/bundle`.  I needed to add each of these files as a submodule to my new repository.  Since I have over twenty plugins, I wrote a quick script to automate the process.

First I moved the current plugins into a different folder and started with blank slate:

```
    mv .vim/bundle old_bundle
    mkdir .vim/bundle
```

Then I wrote a script to loop over these folders, grab the git remote from each, and clone it as a submodule.

```bash
    #!/bin/bash

    set -e
    
    plugins=`ls old_bundle`
    for plugin in $plugins
    do
      echo "Processing $plugin..."
      remote=`cd old_bundle/$plugin && git config remote.origin.url`

      git submodule add $remote .vim/bundle/$plugin
      git commit -m "Added $plugin"
    done
```

Once that completed all of my plugins were cleanly added as submodules into the main repo.

## Synchronizing on my machines

Now that I have a good solution for sharing the content, I still want changes I make to seamlessly make their way onto my other machines, so I've cloned this dotfile repo in `~/Dropbox/dotfiles`.  Since everything is symlinked there, thanks to the script above, it just works.

I just need to commit & push to share my changes with the world.

If you're interested, you can [check out my dotfiles here](https://github.com/subdigital/dotfiles).

