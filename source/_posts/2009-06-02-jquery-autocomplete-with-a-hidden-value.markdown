--- 
layout: post
title: jQuery Autocomplete with a Hidden Value
date: 2009-6-2
comments: true
link: false
---
<p>A number of people commented on my post about a <a href="http://flux88.com/blog/jquery-auto-complete-text-box-with-asp-net-mvc/">jQuery Autocomplete Textbox in ASP.NET MVC</a> wanting to know how to provide a value for the items being displayed.&#160; It’s not an uncommon request.&#160; For many pieces of data you’ll have display values as well as unique identifiers to distinguish &amp; provide reference to the items.</p>  <p>Unfortunately it’s not well document, however this is fully supported with <a href="http://dyve.net/jquery/?autocomplete">Dylan Verheul’s jQuery autocomplete plugin</a>.</p>  <p>The first step is to separate your display names from the values in your result from the server.&#160; We were retuning cities before, like this:</p>  {% codeblock %}HOUSTON, AK
HOUSTON, AL
HOUSTON, TX
HOUCK, AR
HOUGHTON, IA{% endcodeblock %}
<p>The individual items are separated by a new line character.&#160; In order to provide a value for each of these, you have to separate the item with a pipe “|”.</p>
{% codeblock %}HOUSTON, AK<strong>|456</strong>
HOUSTON, AL<strong>|1245</strong>
HOUSTON, TX<strong>|553</strong>
HOUCK, AR<strong>|99</strong>
HOUGHTON, IA<strong>|401</strong>{% endcodeblock %}
<p><em>If your display items might contain a pipe character, then you’ll have to change the separator setting for the plugin.&#160; You can do by providing the option <strong>cellSeparator</strong>.</em></p>
<p>Now that our items have a value coming back from the server, how can we retrieve it when an item is selected?&#160; That is done via the onSelectItem function.&#160; This is a callback that will send you the formatted &lt;li&gt; tag.&#160; If there was a value specified, it will be placed in the <em>extra</em> attribute.</p>
<p>Here’s an example:</p>
<p>$(cities).autocomplete(action_url, {
<br />&#160;&#160;&#160; lineSeparator: '\n',
<br />&#160;&#160;&#160; cellSeparator: '|',
<br />&#160;&#160;&#160; onItemSelect: function(li) {&#160; if(li.extra) alert(&quot;You selected &quot; + li.extra[0]); }
<br /> });</p>
<p>I’ve specified the options for lineSeparator and cellSeparator.&#160; These are the default values, but you can easily change them if the character is a valid portion of the text being returned by the server. </p>
<p>You can use this handler to place the selected value in a hidden field to save it for a form submission.</p>
<p>Hope this helps!&#160; For more information, I suggest you read the source code and examine the <a href="http://dyve.net/jquery/?autocomplete" target="_blank">plugin page source</a> for more examples.</p>
