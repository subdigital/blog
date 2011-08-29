--- 
layout: post
title: A Culture of Microcomponents
date: 2009-5-1
comments: true
link: false
---
<p>Imagine that you are given the opportunity to rewrite (or upgrade with extreme prejudice) one of your older .NET 2.0 (or 1.1) projects using .NET 3.5.&nbsp; You wrote it, so you have intimate knowledge of the current architecture, what parts smell, what works well.&nbsp; You know what custom components you wrote to solve various problems, etc.&nbsp; You also have a ton of lessons learned.&nbsp; Now you get to do again, only this time you have more advanced, sharper tools at your disposal.</p> <p><img style="margin: 0px 20px" align="right" src="http://www.blackwagon.com/Merchant2/graphics/00000001/BRIO010-brio-building-blocks-natural-lg.jpg">I went through this process recently and came up with no shortage of 3rd party libraries I wanted to use for the new version:</p> <ul> <li><a href="https://www.hibernate.org/343.html" target="_blank">NHibernate</a>  <li><a href="http://fluentnhibernate.org/" target="_blank">Fluent NHibernate</a>  <li><a href="http://sourceforge.net/projects/nhcontrib/" target="_blank">NHibernate.Linq</a>  <li><a href="http://www.castleproject.org/container/index.html" target="_blank">Castle Windsor</a>  <li><a href="http://www.castleproject.org/activerecord/documentation/v1rc1/usersguide/validation.html" target="_blank">Castle Validators</a>  <li><a href="http://logging.apache.org/log4net/index.html" target="_blank">log4net</a>  <li><a href="http://www.codeplex.com/AutoMapper" target="_blank">AutoMapper</a>  <li><a href="http://code.google.com/p/elmah/" target="_blank">ELMAH</a>  <li><a href="http://mvccontrib.org" target="_blank">MvcContrib</a>  <li><a href="http://sparkviewengine.com/" target="_blank">Spark</a>  <li><a href="http://jquery.com/" target="_blank">jQuery</a>  <li><a href="http://www.atblabs.com/jquery.corners.html" target="_blank">jQuery rounded corners</a> <li><a href="http://bassistance.de/jquery-plugins/jquery-plugin-autocomplete/" target="_blank">jQuery auto-complete</a>  <li><a href="http://www.codeplex.com/CommonServiceLocator" target="_blank">CommonServiceLocator</a>  <li><a href="http://www.codeplex.com/LINQtoAD" target="_blank">LINQ to ActiveDirectory</a>  <li><a href="http://docu.jagregory.com/" target="_blank">docu</a>  <li><a href="http://nunit.org" target="_blank">NUnit</a>  <li><a href="http://nant.sf.net" target="_blank">NAnt</a></li></ul> <p>This list is nothing to sneeze at, and it's just what I could remember... in fact it's probably a bit longer.&nbsp; This tends to scare people, as it is a lot of stuff to learn.&nbsp; <em>What the heck are these things?&nbsp; Where did they come from?&nbsp; Do I need it?&nbsp; How do I learn it?&nbsp; Why did you include this?</em></p> <p>That's a great question.&nbsp; <strong>Why <em>do</em> I want to use all of these things?</strong>&nbsp;</p> <p>I firmly believe in leveraging the work of others, and writing code that is expressive and easy to maintain.&nbsp; Some of these projects exist solely to make working with another item from the list a lot easier.&nbsp; NHibernate is a great example.&nbsp; I loves me some NHibernate, but writing XML mapping files by hand isn't what I'd call a fun time.&nbsp; Fluent NHibernate makes this so much nicer.&nbsp; The last thing I want to do is reinvent the wheel.</p> <p><img style="margin: 20px" src="http://liambest.com/square.jpg" width="419" height="480"></p> <p>I don't think I'm alone here.&nbsp; Most projects I come across have a similar attitude regarding re-using rather than re-inventing.&nbsp; Most come with a dozen or so additional libraries so that it can function.&nbsp; I recently asked on twitter how many 3rd party libraries folks are using.&nbsp; The average result was about 5, but some were as high as 12.</p> <p>The bottom line for me is:&nbsp; <strong>The value I get from leveraging 3rd party tools is greater than the psychic weight that they cause.&nbsp; </strong>But others may not agree with me.</p> <p>What about the Ruby community?&nbsp; Don't they have this problem?&nbsp; Absolutely.&nbsp; But I don't think they would classify it as a problem, and I'd tend to agree.&nbsp; Say you're writing a ruby app and you somehow want to integrate flickr with twitter and paypal.</p>{% codeblock %}&gt; gem install flickr
&gt; gem install twitter
&gt; gem install paypal
{% endcodeblock %}
<style type="text/css">.csharpcode, .csharpcode pre
{
font-size: small;
color: black;
font-family: consolas, "Courier New", courier, monospace;
background-color: #ffffff;
/*white-space: pre;*/
}
.csharpcode pre { margin: 0em; }
.csharpcode .rem { color: #008000; }
.csharpcode .kwrd { color: #0000ff; }
.csharpcode .str { color: #006080; }
.csharpcode .op { color: #0000c0; }
.csharpcode .preproc { color: #cc6633; }
.csharpcode .asp { background-color: #ffff00; }
.csharpcode .html { color: #800000; }
.csharpcode .attr { color: #ff0000; }
.csharpcode .alt
{
background-color: #f4f4f4;
width: 100%;
margin: 0em;
}
.csharpcode .lnum { color: #606060; }
</style>
<p><img style="margin: 0px 20px" align="right" src="http://www.workingwithrails.com/images/ruby-gem.png?1213632569">...Wait what?&nbsp; That's it?&nbsp; Yep.&nbsp; <strong><a href="http://rubygems.org/" target="_blank">Rubygems</a> is a thing of beauty</strong>.&nbsp; It lowers the barrier to installing 3rd party plugins and libraries.&nbsp; Rails plugins has a similar concept.&nbsp; Need to rate one of your models?&nbsp; {% codeblock %}script/install plugin acts_as_rateable{% endcodeblock %} Want to use jQuery instead of prototype/scriptaculous?&nbsp; simply run {% codeblock %}script/install plugin jrails{% endcodeblock %}
<p></p>
<p>These techniques allow you to add small pieces of functionality to existing applications with relative ease.&nbsp; You don't have to open a web browser &amp; search for the tool.&nbsp; You don't have to download &amp; extract it somewhere.&nbsp; And you don't need to copy it into your project tree.&nbsp; Everything is done with a single command.</p>
<p>It seems as if every concept and service has their own gem or rails plugin.&nbsp; Rails applications today can be built rather simply by composing tiny pieces of functionality written by other people.&nbsp; <br></p>
<p>So why can't we do this in .NET?&nbsp; Well in short, we can... but it requires a culture shift.&nbsp; For starters, in .NET we generally check in all of our dependencies into source control, so that we can always guarantee that each developer has all of the required tools (and the specific versions of such tools).&nbsp; With ruby gems, each gem is installed into a common location, which is consistent across all machines (actually it is configurable, but the point is it's a global directory).&nbsp; To use one of the gems installed on your machine, you simply do this:</p>{% codeblock %}require <span class="str">'hpricot'</span>{% endcodeblock %}
<style type="text/css">.csharpcode, .csharpcode pre
{
font-size: small;
color: black;
font-family: consolas, "Courier New", courier, monospace;
background-color: #ffffff;
/*white-space: pre;*/
}
.csharpcode pre { margin: 0em; }
.csharpcode .rem { color: #008000; }
.csharpcode .kwrd { color: #0000ff; }
.csharpcode .str { color: #006080; }
.csharpcode .op { color: #0000c0; }
.csharpcode .preproc { color: #cc6633; }
.csharpcode .asp { background-color: #ffff00; }
.csharpcode .html { color: #800000; }
.csharpcode .attr { color: #ff0000; }
.csharpcode .alt
{
background-color: #f4f4f4;
width: 100%;
margin: 0em;
}
.csharpcode .lnum { color: #606060; }
</style>
<p>It knows to load up that library from a central location.&nbsp; When this application is deployed to another environment, the same thing occurs.&nbsp; Gems are installed via the same commands as on the dev machines. </p>
<p>Back at ALT.NET Seattle 2009 I convened a session to discuss revitalizing one of the many <em>gems-for-.NET</em> projects.&nbsp; We identified several efforts along similar lines as gems:</p>
<ul>
<li>ngems
<li>cogs
<li>nu
<li>horn
<li>Machine.PartStore</li></ul>
<p> Out of this discussion, a few folks decided to start fresh with a new project (affectionately called <a href="http://github.com/scottcreynolds/rocks/tree/master" target="_blank">rocks</a>), and toy with getting rubygems to work with IronRuby and wrapping it all in our own command line interface.&nbsp; Not much has been done on this except a quick spike, but I think the idea is promising.</p>
<p>I believe that if something like this comes up in the .NET community it will lead to a shift in how we think about dependencies, components, and overall re-use of small pieces of code to build larger applications.&nbsp; </p>
<p>What do you think?</p>
