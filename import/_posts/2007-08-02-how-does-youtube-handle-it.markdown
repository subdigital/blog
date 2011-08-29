--- 
layout: post
title: How Does YouTube Handle It?
date: 2007-8-2
comments: true
link: false
---
<p>I ran across an excellent read about how YouTube's architecture handles so much bandwidth and traffic.</p><p>The core of it is:</p><ul><li>SuSe Linux</li><li>Apache + lighttpd (for videos only)</li><li>Python + C extensions for expensive operations</li><li>Lots of caching</li></ul><p>Many more points to read, but a great reference indeed.&nbsp; Check it out here:&nbsp; <a href="http://highscalability.com/youtube-architecture" target="_blank">http://highscalability.com/youtube-architecture</a>.</p>
