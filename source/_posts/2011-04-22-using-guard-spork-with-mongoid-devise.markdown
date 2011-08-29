--- 
layout: post
title: Using Guard & Spork with Mongoid & Devise
date: 2011-4-22
comments: true
link: false
---
<p>On my last project, I eventually settled on using Guard along with Spork to allow for quicker testing. Specifically, I used:</p>
<ul>
  <li>rspec</li>

  <li>spork</li>

  <li>rb-fsevent</li>

  <li>guard</li>

  <li>guard-rspec</li>

  <li>guard-pow</li>

  <li>guard-spork</li>
</ul>
<p>
You might be saying, <em>"What the hell are all these gems for?!?!"</em>
</p>

<h3>Guard</h3>
<p>This is a lot of development gem dependencies, but once working, it can vastly grease your testing workflow. <a href="https://github.com/guard/guard">Guard</a> is a framework for watching files &amp; doing something when they change. Make sure to use <a href="https://github.com/thibaudgg/rb-fsevent">rb-fsevent</a> as well to make detecting files not melt your machine polling for changes.</p>
<h3>Guard-rspec</h3>
<p><a href="https://github.com/guard/guard-rspec">guard-rspec</a> notices that models and/or specs change, and runs the related spec file automatically. Just running one test makes things faster, but you still have to reload all of rails with each run, making the feedback loop completely undesirable.</p>
<h3>Spork</h3>
<p>This is where <a href="https://github.com/timcharper/spork">Spork</a> comes in. Spork pre-loads your environment, allowing rspec files to run with --drb mode &amp; essentially caching your environment for multiple, fast test runs. That is, unless you change something in the environment (such as config/environment, routes.rb, or Gemile). These changes require spork to be restarted, which is SLOOOOW.</p>
<p>It's not always obvious when spork needs reloading, so sometimes you'd find yourself scratching your head, saying, "this test should be failing... but it's not!" Followed by a head-slap, when you realize you need to bounce spork.</p>
<h3>Guard-spork</h3>
<p>So <a href="https://github.com/guard/guard-spork">guard-spork</a> is a nice way of automatically detecting these changes and reloading spork for you.</p>
<h3>Guard-pow</h3>
<p>Lastly, I'm using <a href="http://pow.cx">pow</a> from 37signals, so any env related changes that require a server restart automatically call touch tmp/restart.txt and pow restarts the app. Guard-pow does this for you.</p>
<h2>Workflow</h2>
<p>It's hard to say what all this means for the developer's workflow, but basically all you need to do is run `guard` in a Terminal tab of its own and let it run. I run `guard` almost all day, and it generally does what I need it to.</p>
<p>Life is good, until you try to use this on another project that uses Mongoid &amp; Devise...</p>
<p>The Problem with Mongoid + Spork</p>
<p>Mongoid include its models with Rails, so that means if you change your models you have to reload rails. Not very friendly with a Spork-type model. Hopefully they'll add a lifecycle hook in the future, but until they do, we can utilize a feature of Spork that can save the day: `trap_method/trap_class_method`.</p>
<p>The details are found <a href="https://github.com/timcharper/spork/wiki/Spork.trap_method-Jujutsu%20(found%20from%20http://ihswebdesign.com/blog/spork-not-reloading/)https://github.com/timcharper/spork/wiki/Spork.trap_method-Jujutsu%20(found%20from%20http://ihswebdesign.com/blog/spork-not-reloading/)https://github.com/timcharper/spork/wiki/Spork.trap_method-Jujutsu%20(found%20from%20http://ihswebdesign.com/blog/spork-not-reloading/">here</a>, but for the impatient, I modified my `spec_helper`'s prefork block to look like this:</p>
{% codeblock lang:ruby %}
Spork.prefork do<br />  ENV["RAILS_ENV"] ||= 'test'<br /><br />
  require 'rails/mongoid'
  Spork.trap_class_method(Rails::Mongoid, :load_models)

  # Now load our environment
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails' 
  ...
{% endcodeblock %}
<p>Basically this forces that call to be loaded later on in the lifecycle.</p>
<p>There's a similar interception done for Device, which likes to load models along with Rails routes. You might also need to use this technique to deal with similar issues with Factory Girl, Machinist, and Shoulda Macros as well.</p>
<p>And now my specs are faster again. Yay!<br /></p>
<h2>Is the Complexity Worth it?</h2>
<p>Is this complexity worth it? <a href="http://twitter.com/garybernhardt">Some</a> would say no, and I'm certainly aware of how much additional "gem weight" this adds to a project.</p>
<p>For a great discussion about how to make your specs fast without requiring the complexity of Spork, check out the latest episode of Destroy All Software: <a href="https://www.destroyallsoftware.com/screencasts/catalog/fast-tests-with-and-without-rails">Fast Specs with and without Rails</a>. These screencasts are excellent..</p>
