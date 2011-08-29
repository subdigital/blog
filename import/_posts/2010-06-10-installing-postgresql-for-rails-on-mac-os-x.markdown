--- 
layout: post
title: Installing PostgreSQL for Rails on Mac OS X
date: 2010-6-10
comments: true
link: false
---
<p>If you're doing any serious Rails work with <a target="_blank" href="http://heroku.com">Heroku</a> you'll eventually want to run the same database server they are, namely PostgreSQL.  One such reason is if you plan on using <a target="_blank" href="http://geokit.rubyforge.org/">Geokit</a>, all of the geo math is done at the database level and thus not available on Sqlite.</p>
<p>There are numerous ways of installing it on Mac OS X, (including a nice &amp; easy MacPorts installer) however I opted for the easier Mac installer.  Why?  Because it installs a nice management console into your Applications folder along with some quick shortcuts to Start &amp; Stop your server.  This is nice because I don't plan on using PostgreSQL <strong>all</strong> the time, only when I work on some projects.</p>
<p><img alt="" style="float: left; margin: 0 20px 20px 20px;" src="https://flux88.s3.amazonaws.com/images/happy-elephant-01.jpg" /></p>
<h2>Installing PostgreSQL Database Server</h2>
<p><strike>First, download the </strike><a target="_blank" href="http://www.postgresql.org/download/macosx"><strike>Precompiled 8.4 binary for Mac OS X 10.4+</strike></a><strike> from the Postgres website.  Alternatively, you might want to use MacPorts.  For this, type:</strike></p>
<p style="color: #f00">Update: &nbsp;Turns out I had problems with this package. &nbsp;Something about 64 bit ruby, 32 bit gems -- anyway the MacPorts method works for me on Snow Leopard. &nbsp;</p>
{% codeblock %}
sudo port install postgresql83 postgresql83-server{% endcodeblock %}
<p><span style="font-size: .8em">Note that 8.4 is out, but some recommend using the same version that Heroku uses, namely 8.3.  For a good MacPort installation walkthrough, check <a target="_blank" href="http://www.gregbenedict.com/2009/08/31/installing-postgresql-on-snow-leopard-10-6/">this article</a>.</span></p>
<p>Next, make sure that the bin folder is in your path.</p>
{% codeblock %}
sudo vim /etc/profile{% endcodeblock %}
<p>Find the line that looks like this:</p>
{% codeblock %}
PATH=&quot;/opt/local/bin:/opt/local/sbin:....&quot;{% endcodeblock %}
<p>Add your path at the end.  Make sure to separate it with a colon to distinguish it from other paths.  If you installed with MacPorts, your path is likely `/opt/local/var/postgresql83/bin`, but if you used the installer, then it would be `/Library/PostgreSQL/8.4/bin`.  Note that you'll have to reload your terminal (or open a new tab) to pick up this change.</p>
<h2>Setting up the pg gem</h2>
<p>Next you'll want the pg gem, which is a native adapter for postgres.  This is much faster than the postgres-pr gem, which is written in ruby.</p>
<p>Make sure you pick the correct architecture for your installation. This part tripped me up.  Following instructions for a MacPorts installation, I used the wrong arch flags.  If you used MacPorts to install it, then you'll use `x86_64` (64-bit) but if you used the standalone installer then you'll use `i386` (32-bit).</p>
{% codeblock %}
sudo env ARCHFLAGS='-arch i386' gem install pg{% endcodeblock %}
<p>If you get an error like `checking for pg_config... no` then make sure that the correct bin folder is in your path.  If instead you get an error like `Can't find the PostgreSQL client library (libpq)` then check your architecture flag and make sure you chose the right one (not for your system, but for the installation of PostgreSQL that you chose).</p>
<h2>Hook it up to rails</h2>
<p>Now we can alter our database.yml file to utilize postgresql for development.</p>
{% codeblock %}
development:
adapter: postgresql
database: my_database
username: rails
password: password{% endcodeblock %}
<p>Note that you'll need to create the database &amp; user ahead of time.</p>
<p>Now you should be good to go!</p>
