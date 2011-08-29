--- 
layout: post
title: A Deleted Response to a TFS Blog Post
date: 2009-7-27
comments: true
link: false
---
<p>Recently I read a blog post by an unnamed TFS MVP.&nbsp; In the post he claimed that TFS was a big win for small companies and started to outline costs.&nbsp; Roughly he said that with the available pricing options you could get adequate licenses for TFS, VSTS, etc.&nbsp; The figures ranged from $7k to roughly $40k.</p>
<p>My response, which is pasted below, was immediately deleted from his blog.&nbsp; <em>Why</em>?&nbsp; Quoting the email I received:</p>
<blockquote>
<p><em>&ldquo;No offense, but I deleted your comment.&nbsp; I make way too much $$ on Team System training &amp; consulting to go publicly plugging alternative options.&rdquo;</em></p>
</blockquote>
<p><strong>WOW.&nbsp; What a complete lack of integrity.&nbsp; </strong></p>
<p><img style="display: inline; margin-left: 0px; margin-right: 0px" align="right" width="319" height="213" alt="" src="http://compoundthinking.com/blog/wp-content/uploads/2007/06/istock_000002694919xsmall.jpg" /></p>
<p>Rather that look out &amp; learn from the broader software community to see what works well, let&rsquo;s just stick our head in the sand &amp; pretend they don&rsquo;t exist!</p>
<p>If TFS MVPs won&rsquo;t even engage to discuss about the product they spend the majority of their time in, what does that say about the product?</p>
<p>Here was my original comment:</p>
<blockquote>
<p>I can honestly say I don't understand how you can feel this way.     <br />
I think if TFS was completely free you'd still have trouble getting small companies to adopt it.&nbsp; why?&nbsp; Because there are more mature tools available.</p>
<p><br />
Git, SVN are far less friction tools for source control.&nbsp; They are easy to get started, 100% free.&nbsp; (Distributed workers being ever present these days, how long until the TFS team realizes that the central commanding server that locks your files is *not* a good approach to source control?)      <br />
Most people I've talked to don't like managing work items within Visual Studio (which has a horrible UX for filling out forms of data -- seriously a dropdown box that is 1600px wide?&nbsp; Gross) and TFS web access is only a small improvement.</p>
<p><br />
Use something like Basecamp, Fogbugz, Unfuddle, whatever.&nbsp; They are very cheap, can integrate with your source control system, and are a joy to use.      <br />
Now let's talk continuous integration.&nbsp; TFS is also clearly not a leader here.&nbsp; Hudson, Cruise Control, and Team City (professional) are all free and superior.&nbsp; Team City literally takes a few minutes to set up.&nbsp; And guess what?&nbsp; It automatically picks up source from SVN or Git, and integrates natively with NUnit.&nbsp; MSTest?&nbsp; Nope, you need a hack for that.</p>
<p><br />
Finally let's talk unit testing tools.&nbsp; MSTest has always lagged behind the other free testing frameworks.&nbsp; Why wait for the Microsoft mothership to come around and release a new version every couple of years when you can get the benefit of updates that keep up with the ever changing landscape of our profession?</p>
<p><br />
The *only* thing I think TFS has a story for is integration.&nbsp; But when you integrate a bunch of mediocre tools, you get a mediocre solution.      <br />
So give me a $100k budget and I'll still choose mostly free tools.</p>
</blockquote>
<p>His full response, name excluded:</p>
<blockquote>
<p><em>&ldquo;Hey, Ben -- long time, no talk.       <br />
Uhhhmmm...no offense but I deleted your comment.&nbsp; I make way too much $$ from Team System training and consulting to go publicly plugging alternative options.&nbsp; It'd be like me going to your blog and dumping on your ASP MVC book or NHibernate or something.&nbsp; As a consultant, I think you probably get the idea.        <br />
&lt;grin /&gt;</em></p>
<em>
<p><br />
Anyway, dude, you might be thinking about TFS2005 more than TFS2008.&nbsp; TFS2005 had some -- uhmmm -- 'issues'.&nbsp; A lot of the issues have been taken care of in 2008.&nbsp; In TFS2008 (and in 2005, although with more difficulty) you can do multiple checkout and there's a decent story for offline access, too.&nbsp; There is locking but, in 3 years of working with TFS, I don't think I've ever used it.</p>
<p><br />
On the VSTS work item UI, yah...I hear ya.&nbsp; It's not as pretty as it could be.&nbsp; That's part of why I do a lot of my work item (bugs, tasks, etc) editing in Excel, or via TS Web Access.&nbsp; Where are you getting the 1600px wide dropdown box?&nbsp; That's just fn awful.&nbsp; There's gotta be a way to make that better -- change the UI control or something.</p>
<p><br />
Why isn't TFS2008 good at continuous integration?&nbsp; Sure, in TFS2005 it was a hacky mess and you had to use 3rd party extensions (like the one I wrote) but in TFS2008, it works great out of the box.        <br />
You nailed why I like VSTS tho -- the integration.&nbsp; Why would I want to deal with multiple products from multiple vendors when I can deal with just one?&nbsp; For you and me, keeping those disparate servers/apps up and running isn't a huge deal but to a lot of organizations, it's a big pain in the ass...at a minimum it's a distraction.&nbsp; Sure it's free but it's a free distraction.&nbsp; (shrug)        <br />
Plus, there's the data warehouse on the back-end of TFS.&nbsp; TFS is constantly collecting all the data from your project plan, defects, builds, unit tests within the builds, code coverage within the builds and dumping them into a data warehouse.&nbsp; From there you can get comprehensive, up-to-the-minute (well, by default up-to-the-hour) intelligence about the status of your projects.&nbsp; This helps you to see what's going on on your project and (hopefully) expose when you're going off the rails.        <br />
Wait 'til VSTS2010 comes out!&rdquo;</p>
</em></blockquote>
<p>I think his response is perfectly valid.&nbsp; It opens the door to discuss the points.&nbsp; What frustrates me the most is the unwillingness to engage publicly.</p>
<p><strong>Update: &nbsp;Ben Day responded here:&nbsp;</strong><a href="http://blog.benday.com/archive/2009/07/27/23233.aspx"><strong>http://blog.benday.com/archive/2009/07/27/23233.aspx</strong></a></p>
