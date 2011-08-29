--- 
layout: post
title: JavaScript memory leaks
date: 2007-2-28
comments: true
link: false
---
<p><font style="BACKGROUND-COLOR: #fffff9">Most people don&rsquo;t realize this, but JavaScript can leak memory if you don&rsquo;t write it properly.&nbsp; This is a strange concept, because for one, it runs in the browser, two, it&rsquo;s a scripting language so it <em>feels</em> simpler, and 3 because you usually don&rsquo;t do very much in JavaScript.</font></p><p>But, when JavaScript is written carelessly, it can lead to enourmous memory leaks that can actually crash the browser.</p>Take a look at this <a href="http://www.codeproject.com/jscript/leakpatterns.asp" target="_blank" title ="Code Project Article">incredible article onjavascript memory leakage</a> up at CodeProject posted by Volkan Ocelik to find out the different leakage patterns and how to avoid them.In order to fully understand how to avoid memory leakage, it is important that you understant closures.The best explanation I have found is <a href="http://jibbering.com/faq/faq_notes/closures.html" target="_blank" title ="jibbering.com">here</a>.So make sure you think when writing JavaScript so you don't hurt yourself.
