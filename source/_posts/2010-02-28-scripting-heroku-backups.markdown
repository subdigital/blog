--- 
layout: post
title: Scripting Heroku Backups
date: 2010-2-28
comments: true
link: false
---
<p>With any website, having a regular backup is critical.  <a href="http://heroku.com">Heroku</a>, the awesome Rails cloud service that hosts <a href="http://pockettabs.com">Pocket Tabs</a> and a handful of other sites for me, provides the ability to do backups of code and data through a concept called <strong>bundles</strong>.</p>
<p>When you enable the free bundles support on Heroku, you only get 1 bundle.  You can download it and destroy it to free up the space for the next bundle, but results in 3-4 commands just to get a backup of the site.  You can pay for additional bundles, but with a little script we can get by with just one.</p>
<p>Here's the typical workflow:</p>
{% codeblock %}
&gt; heroku bundles:capture my-site-2010-02-28
&gt; heroku bundles:download my-site-2010-02-28
#places my-site.tar.gz in the current directory
&gt; heroku bundles:destroy my-site-2010-02-28{% endcodeblock %}
<p>With <a target="_blank" href="http://www.mail-archive.com/heroku@googlegroups.com/msg02903.html">some help</a>, I created a rake task to do this work for me.</p>
<p>In your rails project, place a new rake file in the `lib/tasks` folder. I called mine `backup_site.rake`.  The standard Rails Rakefile knows how to load up any of your custom rake files in this folder.  It's a good idea to give your rake tasks a namespace to keep everything tidy.  Here's mine:</p>
{% codeblock %}
namespace :pockettabs do
desc 'Captures a heroku bundle and downloads it.  The downloaded files are stored in backups/'
task :backup do
timestamp = `date -u '+%Y-%m-%d-%H-%M'`.chomp
bundle_name = &quot;pockettabs-#{timestamp}&quot;
puts &quot;Capturing bundle #{bundle_name}...&quot;
`heroku bundles:capture --app pockettabs '#{bundle_name}'`
# poll for completion (warning, a little hacky)
begin
bundles = `heroku bundles --app pockettabs`
end while bundles.match(/complete/).nil?
# download &amp; destroy the bundle we just captured
%w(download destroy).each do | action |
`heroku bundles:#{action} --app pockettabs '#{bundle_name}'`
end
`mv pockettabs.tar.gz backups/#{bundle_name}.tar.gz`
puts &quot;Bundle captured and stored in backups/#{bundle_name}.tar.gz&quot;
end
end{% endcodeblock %}
<p>Now I can easily just run a rake task any time I want to backup the site.</p>
{% codeblock %}
&gt; rake pockettabs:backup
# Capturing bundle pockettabs-2010-02-28-02-40...
# Bundle captured and stored in backups/pockettabs-2010-02-28-02-40.tar.gz{% endcodeblock %}
<p>Next step is to put this in a cron job so that I don't have to remember to do it.</p>
