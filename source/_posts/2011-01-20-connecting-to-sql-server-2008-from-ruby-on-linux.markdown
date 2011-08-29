--- 
layout: post
title: Connecting to SQL Server 2008 from Ruby on Linux
date: 2011-1-20
comments: true
link: false
---
<p>This is way hard than it should be, but once you go "off the rails" not everything is candy &amp; roses and chocolate covered bunnies. Of course, there is still a great community of talented folks producing stuff that makes all of this work.</p>
<p>The trick is to know what to look for. This post is for you, dear reader, to hopefully avoid all of the trial and error that I went through and hopefully get it to just work.</p>
<p>So, in my quest to connect a little ruby app on Linux to a SQL Server 2008 instance on Windows, I stumbled across the magical combination that allowed me to perform this task.<br /></p>
<p>All of these commands were run on Ubuntu 10.4.</p>
<h2>Step 1: Get unixODBC.</h2>
<p>You'll be connecting via ODBC, so let's grab this one. There's also iODBC, but I didn't give that one a try.<br /></p>
{% codeblock %}
sudo apt-get install unixodbc-dev
{% endcodeblock %}
<h2>Step 2: Get FreeTDS</h2>
<p>TDS stands for "Table Data Stream" and is the communication protocol that Sybase &amp; SQL Server use. There are plenty of commercial drivers out there for just about every operating system, but one stood out to me... <a href="http://freetds.org/">FreeTDS</a>. I'll give you 3 guesses why I liked this one (but you'll only need 1).<br /></p>
<p>We'll also need the ODBC connector for this.</p>
<p>{% codeblock %}sudo apt-get install freetds tdsodbc{% endcodeblock %}</p>
<h2>Step 3: Configure-shit</h2>
<p>There are 3 INI files that we need to modify. When I did this on my Mac, they were in /usr/local/etc, but on Ubuntu it was all in the /etc directory.<br /></p>
<p>Confirm that the FreeDTS &amp; TDSODBC drivers are in place by looking in `/usr/lib/odbc` for the files `libtdsodbc.so` and `libtdsS.so`. We'll be using those in the next step.</p>
<p>Using your favorite editor, open up `/etc/odbcinst.ini`. This file might not exist yet, that's okay.</p>
{% codeblock %}
sudo vim /etc/odbcinst.ini
{% endcodeblock %}<br />
<p>Here's where we tell unixODBC which ODBC drivers the system supports. We'll add the following text:</p>
{% codeblock %}
[FreeTDS]
Description = FreeTDS Driver
Driver = /usr/lib/odbc/libtdsodbc.so
Setup = /usr/lib/odbc/libtdsS.so
FileUsage = 1
CPTimeout = 5
CPReuse = 5
{% endcodeblock %}<br />
<p>Save that file. Next up we should configure FreeTDS to define our data sources.<br /></p>
{% codeblock %}
sudo vim /etc/odbc/freetds/freetds.conf
{% endcodeblock %}<br />
<p>There should be some example configurations in here. Also note that here is where you can un-comment a line to enable debug output if you're having trouble (I needed this). Here is my configuration:</p>
{% codeblock %}
#my sql server (SQL Server 2008)
[my_database]
host = 11.22.33.44 #no this isn't a real IP. you think I'm crazy?
port = 1433 #change this if you're running your db on a non-standard port
tds version = 8.0
{% endcodeblock %}
<p>One last piece of configuration is needed. This is the general system datasources configuration.<br /></p>
{% codeblock %}
sudo vim /etc/odbc.ini
{% endcodeblock %}The following should be fairly obvious configuration:<br />
{% codeblock %}
[my_database] #note this doesn't have to match what's in freetds.conf
Servername = my_database #this matches what's in freetds.conf
Driver = FreeTDS #this matches the driver you configured in odbcinst.ini
Database = YOUR_DATABASE_HERE
{% endcodeblock %}
<h2>Step 4: Try it out</h2><br />
Using the unixODBC tool, test out your connection:<br />
{% codeblock %}
isql my_database uid password
{% endcodeblock %}If you had any errors, you'll get something like "Cannot SQLConnect". If this happens, check your debug log (if you enabled it in freetds.conf). In my case I forgot to enable Mixed Mode authentication on the SQL Server side.<br />
<br />
<h2>Step 5: Install the gem</h2><br />
We'll be using a nice gem called <a href="https://github.com/rails-sqlserver/tiny_tds">tiny_tds</a>.<br />
{% codeblock %}
gem install tiny_tds
{% endcodeblock %}With that installed, let's test it out!<br />
Launch `irb`:<br />
{% codeblock %}
require 'tiny_tds'
client = TinyTds::Client.new(:dataserver =&gt; 'my_database', :username=&gt;'user', :password=&gt;'password')
client.closed? # should be false, if it's true you probably had an error connecting
client.execute("SELECT getdate()").each {|row| puts row}
{% endcodeblock %}
<p>If you got a date back, then your connection is working properly. <strong>Huzzah</strong>!</p>
