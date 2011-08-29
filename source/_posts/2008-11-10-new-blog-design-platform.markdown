--- 
layout: post
title: New Blog Design / Platform
date: "2008-11-10"
comments: true
link: false
---
<p>My blog is now running on <a href="http://graffiticms.com">Graffiti</a>. &nbsp;I also updated the design a little bit. &nbsp;I decided that after the lack of stability on my VPS with <a href="http://godaddy.com">Go Daddy</a> that I'd try out a real host. &nbsp;So I've moved my blog over to <a href="http://www.orcsweb.com">ORCS Web</a>. &nbsp;So far, things are great.</p>
<p>Graffiti has a tool to import posts from DasBlog, which is nice, however I wanted to preserve all of my old posts. &nbsp;A simple lookup table, joined with the new Graffiti Posts table gave me the information I needed to map the URLs. &nbsp;Then I created an HttpModule to intercept requests for the old URLs and 301 redirect them to the new ones.</p>
<p>I tested about 20 URLs and it worked fine for me, but if you notice a post that no longer works, please let me know!</p>
<p>What do <em>you</em> think of the new blog?</p>
