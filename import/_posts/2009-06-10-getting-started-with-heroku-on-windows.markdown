--- 
layout: post
title: Getting Started with Heroku on Windows
date: 2009-6-10
comments: true
link: false
---
<p><a href="http://heroku.com" target="_blank">Heroku</a> looks to be a very promising way of writing Rails applications with easy deployment, source control, and hosting all built-in.</p>  <p>Unfortunately, the windows story of <a href="http://rubyonrails.org" target="_blank">Rails</a> development, <a href="http://rubygems.org" target="_blank">ruby gems</a>, <a href="http://git-scm.com/" target="_blank">Git</a>, <a href="http://www.sqlite.org/" target="_blank">SQLite</a>, are all incredibly horrible, and make it tough to get started.&#160; Wish I were <a href="http://flux88.com/blog/upgrading-my-hackintosh-to-10-5-7/" target="_blank">on a Mac</a>, but yeah… not on my laptop… yet.</p>  <h3>Step 1:&#160; Install <a href="http://www.cygwin.com/" target="_blank">Cygwin</a></h3>  <p>I can’t stress enough how awesome this tool is.&#160; it gives you a unix-style shell that supports a number of things, namely Git.&#160; You can’t run Git on windows without msys-git or similar and it is required for Heroku.&#160; <em>(Git is the deployment mechanism for packaging up your changes and sending them to Heroku)</em>.</p>  <p>When you install cygwin, make sure to expand the packages and install *at least* the following:</p>  <ul>   <li>gcc </li>    <li>gcc-g++ </li>    <li>git </li>    <li>git-completion </li>    <li>git-gui </li>    <li>gitk </li>    <li>grep </li>    <li>gzip </li>    <li>libsqlite3-devel </li>    <li>libsqlite3_0 </li>    <li>make </li>    <li>man </li>    <li>openssh </li>    <li>ruby&#160; &lt;—some say this is buggy, but it seems to work for me </li>    <li>sqlite3 </li>    <li>tar </li>    <li>wget </li> </ul>  <p>Wait for it to download and install those packages.&#160; There might be others, but those are the major ones installed on my machine.&#160; If you already have cygwin installed, you can run the setup.exe file again and select the packages you’re missing.</p>  <h3>Step 2:&#160; Install Rubygems</h3>  <p>Note that this is required even if you already have the one-click ruby installer on windows.&#160; Steven Harman wrote about <a href="http://stevenharman.net/blog/archive/2008/11/12/installing-rubygems-in-cygwin.aspx" target="_blank">how to do this in cygwin</a>:</p>  <blockquote>   <ol>     <li><em>Download the RubyGems tarball from </em><a href="http://rubyforge.org/projects/rubygems/"><em>Ruby Forge</em></a> </li>      <li><em>Unpack the tarball </em></li>      <li><em>In a bash terminal, navigate to the unpacked directory </em></li>      <li><em>Run the following command:</em>         {% codeblock %}<em>ruby setup.rb install</em>{% endcodeblock %}
</li>
<li><em>Update RubyGems by running the following:</em>
{% codeblock %}<em>gem update --system</em>{% endcodeblock %}
</li>
</ol>
<p><em>Note: You may need to run the updated command twice if you have any previously installed gems.</em></p>
</blockquote>
<p><em><strong>Note, if you try to run some ruby files and you get a “could not load rubygems” error, you may need to unset the RUBYOPT environment variable.&#160; The windows version might be conflicting with the cygwin version.</strong></em></p>
<h3>Step 3:&#160; Install sqlite3-ruby gem</h3>
<p>The sqlite3-ruby gem is actually a CGem (not ruby) so it needs a windows binary. Unfortunately, there isn’t a windows version yet, so you need to back up to the latest one that does, which is 1.2.3 as of this post.</p>
{% codeblock %}gem install sqlite3-ruby –v 1.2.3{% endcodeblock %}
<p><strong></strong></p>
<p><strong>If this fails with an error saying “looking for sqlite.h…no” then you probably haven’t installed the libsqlite3_devel package in cygwin. This tripped me up.</strong></p>
<h3>Step 4: Install json gem</h3>
<p>Again, the latest version of this gem doesn’t work yet with Windows, so you have to request version 1.1.1.</p>
{% codeblock %}gem install json –v 1.1.1{% endcodeblock %}
<h3>&#160;</h3>
<h3>Step 5: Install Heroku gem</h3>
{% codeblock %}gem install heroku{% endcodeblock %}
<h3>&#160;</h3>
<h3>Step 6: Create an SSH key file</h3>
<p>In order to communicate securely with heroku, you need to create an SSH key file.</p>
{% codeblock %}$ cd ~/
$ mkdir .ssh
$ cd .ssh
$ ssh-keygen –C “my key” –t rsa{% endcodeblock %}
<p>&#160;</p>
<p>This should create a public &amp; private key file.&#160; Heroku will look for this.</p>
<p>Now we can follow the standard heroku instructions, which are pretty simple.&#160; Here’s how you’d create a sample rails app, initialize git, add files, and create the app on heroku.&#160; Finally we’ll push the code &amp; you can see it running online.</p>
{% codeblock %}$ rails foo
$ cd foo
$ git init
$ git add .
$ git commit –m “adding files”
$ heroku create (type in heroku credentials when prompted)
$ git push heroku master{% endcodeblock %}
<p>&#160;</p>
<p>You’ll be given a URL when you create the app on heroku, so after you push you can visit <a href="http://your-app-name.heroku.com">http://your-app-name.heroku.com</a> to see it live!</p>
<p>Hope this helps someone else get started faster than me!</p>
