--- 
layout: post
title: e - Text Editor - no such file exists -- ubygems
date: 2007-8-23
comments: true
link: false
---
There's no doubt that <a href="http://www.e-texteditor.com">e</a> kicks ass.&nbsp; On one of my computers, however I was having a problem using some of the bundles.&nbsp; Specifically some of the bundles utilize <a href="http://www.cygwin.com/">cygwin</a> to do their magic.<br><br>I was receiving this weird error, where ruby is complaining that it can't locat a file named "ubygems".&nbsp; Obviously, they are referring to rubygems, and the problem exists when you have a windows install of ruby and a cygwin install of ruby.<br><br>To fix it you need to reinstall ruby gems within cygwin.&nbsp; Download the <a href="http://rubyforge.org/frs/?group_id=126">latest version of rubygems</a> from rubyforge.&nbsp; Put the tarball in the c:\cygwin\home\USER folder, then open up your cygwin prompt and type:<br>{% codeblock %}$ tar -x -f rubygems-0.9.4.tgz(this will change if you download a different version)<br>$ cd rubygems-0.9.4<br>$ unset RUBYOPT<br>$ ruby setup.rb<br><br>{% endcodeblock %}<p>At this point rubygems should be installing and you should be good to go.&nbsp; Back to "e goodness"!<br></p>
