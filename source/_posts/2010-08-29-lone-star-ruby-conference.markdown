--- 
layout: post
title: Lone Star Ruby Conference
date: 2010-8-29
comments: true
link: false
---
<p><img src="http://farm5.static.flickr.com/4115/4938888779_3bded8694c_m.jpg" height="240" width="179" alt="" /><br /></p>
<p>I went to (and spoke at) my first Ruby conference this past weekend. <a href="http://lonestarrubyconf.com/">Lone Star Ruby Conference</a> was held in Austin and consisted of 1 training day &amp; 2 days of conference sessions. There were 2 tracks, and even still I was often conflicted on which session to attend. The hallway conversations were also quite engaging.</p>
<p><b>Day 1: Ruby Intrigue</b></p>
<p>I went to the Ruby Intrigue full-day training. I think by about 10:00 I was already thinking the trip to Austin had been worth it. I learned some ruby tricks that I just didn't know before. The agenda was to create a Web Crawler, Asteroids Clone, and SMS Gateway all in Ruby. We explored areas of the language that we might not otherwise see writing web applications. The Web Crawler was refactored multiple times to attempt to improve performance by using threads, processes, queues, and even jruby.</p>
<p><img src="http://farm5.static.flickr.com/4141/4939474238_7f18c6c855_m.jpg" height="179" width="240" alt="" /><br /></p>
<p>Next up, we learned how to leverage the <a href="http://code.google.com/p/gosu/">Gosu</a> library to write games in Ruby. We wrote a complete asteroids clone that is quite impressive. You can see the code for this <a href="http://github.com/adambair/asteroids">on github</a>.</p>
<p><a href="http://www.flickr.com/photos/81671640@N00/4938892159/"><img src="http://farm5.static.flickr.com/4100/4938892159_d531e03450_m.jpg" height="179" width="240" alt="" /></a><br /></p>
<p>Lastly we dug into some SMS integration using the sms_fu gem. Unfortunately there were some gem dependency problems and not everyone was able to get it working. I spent that time improving the asteroids game. :)</p>
<p>I really want to thank the guys from Intridea who put it on, specifically <a href="http://twitter.com/pradeep24">Pradeep Elankumaran</a>, <a href="http://twitter.com/adambair">Adam Bair</a>, and <a href="http://twitter.com/brendanlim">Brendan Lim</a>. They did a great job and I learned a lot. You can see some of the photos from this day on <a href="http://www.flickr.com/photos/brendanlim/sets/72157624711367051/with/4939681028/">Brendan's Flickr</a>.</p>
<p>The material that we went over can be found <a href="http://github.com/intridea/ruby_intrigue">here</a>.</p>
<p><b>Day 2</b></p>
<p>The day kicked off with an excellent keynote by Glen Vanderburg about the history of (Software) Engineering, studying the original papers that kicked off 40 years of Waterfall software projects. Truly interesting.</p>
<p>We learned how to Decipher Yehuda from Greg Pollack, get a glimpse of how a Vim Ninja works, a little bit of Hashrocket culture, and a fascinating tour of languages by Bruce Tate. Jesse Wolgamott (my co-hort at <a href="http://lonestarrubyconf.com/">ChaiONE</a>) gave a talk about NoSQL, giving some good comparisons on a few of the tools.</p>
<p><a href="http://www.flickr.com/photos/81671640@N00/4938892713/"><img src="http://farm5.static.flickr.com/4076/4938892713_851878cd55_m.jpg" height="179" width="240" alt="Greg Pollack Deciphers Yehuda" /></a><br /></p>
<p>The highlight of Day 2, was hearing <a href="http://twitter.com/mojombo">Tom Preston-Werner</a> (co-founder of Github) give a closing keynote on what made him successful. I really enjoy using Github, and it was interesting to hear the story behind it. Afterwards he bought beer for everyone at the Draught House. Unfortunately I couldn't make it because I needed to go rest up, as my voice was getting worse &amp; worse.</p>
<p><a href="http://www.flickr.com/photos/81671640@N00/4938893621/"><img src="http://farm5.static.flickr.com/4077/4938893621_2f6e2f3881_m.jpg" height="179" width="240" alt="Tom Preston-Werner (co-founder of Github) with some parting advice." /></a><br /></p>
<p><b>Day 3</b></p>
<p>I enjoyed a number of sessions this day. First was Nick Gauthier explaining how he took a 13m-long test run down to 18 seconds by using a few gems, some file system tweaks, and leveraging all cores of his machine by using <a href="http://rubygems.org/gems/hydra">Hydra</a>. Quite impressive, and a little bit intimidating. I clearly need to know more about how to tune my machine!</p>
<p>Next was Rogelio J. Samour from Hashrocket (and author of <a href="http://github.com/therubymug/hitch">Hitch</a>) talking about how to effectively use rvm and gemsets. I don't know what I was waiting for, but my new philosophy will be: rvm &amp; gemset for every new project I work on. Combined with a .rvmrc there's really no reason not to.</p>
<p>In the afternoon I gave a talk on <a href="http://heroku.com">Heroku</a>, and I think it went well. There were probably 200+ people in the room and my nasty cold made my voice a little scratchy, but luckily it held out, and I was able to do all the material planned in the 35 minutes allotted. I was even given a Heroku t-shirt to sport up on the stage, which I'll wear proudly.</p>
<p>The slides are available here:</p>
<div style="width:425px" id="__ss_5085906">
<strong style="display:block;margin:12px 0 4px"><a href="http://www.slideshare.net/subdigital/a-scalable-rails-app-deployed-in-60-seconds-5085906" title="A Scalable Rails App Deployed in 60 Seconds">A Scalable Rails App Deployed in 60 Seconds</a></strong><object id="__sse5085906" width="425" height="355">
<param name="movie" value="http://static.slidesharecdn.com/swf/ssplayer2.swf?doc=heroku-100829222853-phpapp01&amp;stripped_title=a-scalable-rails-app-deployed-in-60-seconds-5085906" />
<param name="allowFullScreen" value="true" />
<param name="allowScriptAccess" value="always" />
<embed name="__sse5085906" src="http://static.slidesharecdn.com/swf/ssplayer2.swf?doc=heroku-100829222853-phpapp01&amp;stripped_title=a-scalable-rails-app-deployed-in-60-seconds-5085906" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="425" height="355" />
</object>
</div>
<p>The <a href="http://chaione.com">ChaiONE</a> crew, during a break:</p>
<p><a href="http://www.flickr.com/photos/81671640@N00/4938893117/"><img src="http://farm5.static.flickr.com/4082/4938893117_f065ebfe48.jpg" height="121" width="500" alt="The ChaiONE crew at Lone Star Ruby Conf 2010" /></a></p>
<p>I also had to go check out the Austin Man vs Food venue, Round Rock Donuts:</p>
<p><a href="http://www.flickr.com/photos/81671640@N00/4938894487/"><img src="http://farm5.static.flickr.com/4096/4938894487_a742303b05_m.jpg" height="179" width="240" alt="" /></a><br /></p>
<p><a href="http://www.flickr.com/photos/81671640@N00/4938894961/"><img src="http://farm5.static.flickr.com/4117/4938894961_fab74077c2_m.jpg" height="179" width="240" alt="Gigantic Donuts from Round Rock Donuts" /></a><br /></p>
<p>All in all, I had a fantastic time at Lone Star Ruby Conference and I absolutely will be back next year.</p>
