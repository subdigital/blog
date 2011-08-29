--- 
layout: post
title: Increasing Shared Memory for Postgres on OS X
date: 2011-4-14
comments: true
link: false
---
<p>I came across a cryptic error while trying to create another database instance for my local Postgresql server. The error was:</p>
<blockquote>
  {% codeblock %}
creating template1 database in data/base/1 ...
FATAL: could not create shared memory segment: Cannot allocate memory
DETAIL: Failed system call was shmget(key=1, size=1318912, 03600).
HINT: This error usually means that PostgreSQL's request for a shared<br />memory segment exceeded available memory or swap space. To reduce the <br />request size (currently 1318912 bytes), reduce PostgreSQL's shared_buffers <br />parameter (currently 50) and/or its max_connections parameter (currently 10).
The PostgreSQL documentation contains more information about shared memory <br />configuration.
child process exited with exit code 1
initdb: removing contents of data directory "data"
{% endcodeblock %}
</blockquote>
<p>The issue is that your Mac is not configured for "server" level resource usage. In order to check what your kernel settings are for shared memory, type:</p>
{% codeblock %}
sysctl -a
{% endcodeblock %}
<p>Look for keys that start with `kern.sysv.sh____`. Note that the numbers are somewhat related, so you have to change them together. Some helpful detail was found on <a href="http://support.bitrock.com/article/postgresql-cannot-allocate-memory-on-mac-os-x" target="_blank">this post</a>:</p>
<blockquote>
  Note that (kern.sysv.shmall * 4096) should be greater than or equal to kern.sysv.shmmax. kern.sysv.shmmax must also be a multiple of 4096.
</blockquote>
<p>You can set these values temporarily with `sysctl -w [keyname] [value]`, but to make them permanent, you can write the values to `/etc/sysctl.conf`. Here are the values I used:</p>
{% codeblock %}
kern.sysv.shmmax=1610612736
kern.sysv.shmall=393216
kern.sysv.shmmin=1
kern.sysv.shmmni=32
kern.sysv.shmseg=8
kern.maxprocperuid=512
kern.maxproc=2048
{% endcodeblock %}
<p>You'll need to reboot, but once you're back up you should be able to create more Postgres databases with ease.<br /></p>
