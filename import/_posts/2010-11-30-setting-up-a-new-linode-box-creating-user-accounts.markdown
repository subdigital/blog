--- 
layout: post
title: Setting up a new Linode Box - Creating User Accounts
date: "2010-11-30"
comments: true
link: false
---
<p>I'm setting up a new <a href="http://linode.com">Linode</a> box for a client. (Speaking of Linode, it's freaking awesome and you should sign up. If you do, use this <a href="http://www.linode.com/?r=5054fa2264e88490f408a80da62eea5d5d99ee6a">link to give me some bonus credit</a>).</p>
<p>For the Linux distro I chose Ubuntu 10.4 (32-bit). This is just the one I know the best.</p>
<p>One of the first things I like to do is set up a personal user account so that I don't use the root. This is so less-than-intuitive I have to look it up every time.</p>
<p>Here are my notes so that I don't forget.</p>
<blockquote>
<p><span style="font-family: Arial; font-size: medium;">As root, run the useradd command:</span></p>
<div style="font-family: Arial; font-size: medium;">
<br />
</div>
<div style="font-family: Arial; font-size: medium;">
<font face="'Andale Mono'"><b>sudo useradd -d /home/testuser -m -s /bin/bash testuser</b></font>
</div>
<div style="font-family: Arial; font-size: medium;">
<br />
</div>
<div style="font-family: Arial; font-size: medium;">
Reset their password:
</div>
<div style="font-family: Arial; font-size: medium;">
<br />
</div>
<div style="font-family: Arial; font-size: medium;">
<font face="'Andale Mono'"><b>sudo passwd testuser</b></font>
</div>
<div style="font-family: Arial; font-size: medium;">
<br />
</div>
<div style="font-family: Arial; font-size: medium;">
Then add them to the sudoers file:
</div>
<div style="font-family: Arial; font-size: medium;">
<br />
</div>
<div style="font-family: Arial; font-size: medium;">
<font face="'Andale Mono'"><b>visudo</b></font>
</div>
<div style="font-family: Arial; font-size: medium;">
<br />
</div>
<div style="font-family: Arial; font-size: medium;">
Create a user alias for the company accounts:
</div>
<div style="font-family: Arial; font-size: medium;">
<br />
</div>
<div style="font-family: Arial; font-size: medium;">
<font face="'Andale Mono'"><b>User_Alias CHAIONE = user1, user2</b></font>
</div>
<div style="font-family: Arial; font-size: medium;">
<br />
</div>
<div style="font-family: Arial; font-size: medium;">
Then add this line lower down:
</div>
<div style="font-family: Arial; font-size: medium;">
<br />
</div>
<div style="font-family: Arial; font-size: medium;">
<font face="'Andale Mono'"><b>CHAIONE ALL=ALL</b></font>
</div>
<div style="font-family: Arial; font-size: medium;">
<br />
</div>
<div style="font-family: Arial; font-size: medium;">
For future users, just add them to the CHAIONE alias
</div>
</blockquote>
