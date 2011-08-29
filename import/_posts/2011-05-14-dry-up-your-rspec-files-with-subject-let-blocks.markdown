--- 
layout: post
title: Dry up Your Rspec Files with subject & let Blocks
date: 2011-5-14
comments: true
link: false
---
<p>Rspec is pretty awesome, however due to its flexibility, often times I find that people write specs in ways that either a) aren't structured very well, or b) use the wrong terminology to group up common contexts &amp; behaviors.</p>

<p><strong>Update:  Be sure to read David Chelimsky's suggestions in the comments.</strong></p>

<p>A friend of mine who is fairly new to Rspec, and asked me to provide some feedback on some tests that he wrote.<br /></p>
<p>Here is the before:</p>

<script src="https://gist.github.com/972835.js?file=original_card_spec.rb"></script>

<p>The only real problems here are:</p>
<ul>
  <li>Lots of duplicated setup code. If the initialization aspect of the Card design ever called for something other than a string, we'd have a lot of test code to fix.</li>

  <li>Lots of "extra" code to test a simple value. If it smells like duplication to type "it 'has a value of 13'" and then type the same thing, only in ruby code, then you're right.</li>
</ul>
<p>The rspec constructs I recommend to deal with this are `subject,` `let, and` `its` blocks.</p>
<ul>
  <li><b><span style="font-weight: normal;"><b>Subject</b> blocks allow you to control the initialization of the subject under test. If you don't have any custom initialization required, then you're given a default `subject` method already. All it does is call `new` on the class you're testing.</span></b></li>

  <li><span style="font-weight: normal;"><b>Let</b> blocks allow you to provide some input to the subject block that change in various contexts. This way you can simply provide an alternative `let` block for a given value and not have to duplicate the setup code for the subject over again. Let blocks also work inside of `before :each` blocks if you need them.</span><br /></li>

  <li><span style="font-weight: normal;"><b>Its</b> blocks allow you to test methods on the subject that return a simple value. The benefit of using this over the more wordy version above is that it can actually format the test output for you.</span><br /></li>
</ul>
<p>Here is the same example above, using the above techniques to clean things up a bit.</p>

<script src="https://gist.github.com/972835.js?file=better_card_spec.rb"></script>

<p>And here is the output of the above spec:</p>
{% codeblock %}
Card
  #value
    Two of Hearts
      value
        <span style="color: #2f2">should == 2</span>
    Face Cards
      King of Clubs
        value
          <span style="color: #2f2">should == 13</span>
      Queen of Clubs
        value
          <span style="color: #2f2">should == 12</span>
      Jack of Hearts
        value
          <span style="color: #2f2">should == 11</span>
    Bad Value
      <span style="color: #2f2">should raise StandardError</span>
{% endcodeblock %}
<p>I think that's a big improvement.</p>

<p><em>Note:  The code in this post is delivered via Github Gists, which unfortunately don't render in Google Reader.  Click through to see the code.</em></p>
