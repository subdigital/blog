--- 
layout: post
title: iPhone Apps Don't Live in a Vacuum
date: 2010-6-3
comments: true
link: false
---
<p>Most of the iPhone apps that I work on don't exist in a vacuum. &nbsp;That is, they require data that exists somewhere on the server. &nbsp;Grabbing data from the server is seemingly simple, but you have to dig deeper if you want a truly seamless experience for the user.</p>
<p>Consider the naive approach:</p>
<ul>
<li>App Starts up</li>
<li>App Fetches http://someserver/foo.xml</li>
<li>App updates the UI with fresh data</li>
</ul>
<p>If we do this then the server is pinged <strong>every single time the app loads</strong>. &nbsp;There are numerous problems with this approach. &nbsp;The user notices a delay every time they use the app, and most of the time you're loading the same data over and over again. &nbsp;What happens if the user is offline?</p>
<p>&quot;Aha!&quot; You say. &nbsp;Let's just enable caching. &nbsp;That's not a terrible idea. &nbsp;So you go down the route of implementing a naive caching strategy: &nbsp;After fetching a resource from the server, cache it on disk so that you don't load it again.</p>
<blockquote>
<p>Side note: &nbsp;TTURLRequest from the <a href="http://github.com/facebook/three20">Three20</a> Library does this out of the box.</p>
</blockquote>
<p>Now what happens?</p>
<ul>
<li>App Starts up</li>
<li>App Fetches http://someserver/foo.xml</li>
<li>App updates the UI with fresh data</li>
<li>User quits app</li>
<li>User launches app again</li>
<li>App Loads data from local cache</li>
<li>App updates the UI with cached data</li>
</ul>
<p>Our 2nd launch is improved immensely, and now the app even works offline! &nbsp;Yipee! &nbsp;What could be wrong now? &nbsp;Well now we have another problem: &nbsp;If we update data on the server, the clients won't know about it and will continue to server stale data to the UI. &nbsp;At what point should you invalidate the cache? &nbsp;Hourly? &nbsp;Daily? &nbsp;Weekly?</p>
<p>To answer that you really have to examine your domain. &nbsp;For one of our clients, they have data that fits all over this spectrum:</p>
<p><img border="0" alt="data-change-frequency" width="512" height="80" src="https://flux88.s3.amazonaws.com/assets/data-change-frequency.png" /></p>
<p>Not much data falls on the left side of this chart, but occasionally you find some that matches. &nbsp;US States for example might be categorized as &quot;Never Changes&quot;. &nbsp; This app in question is about sports stats, so stats for past seasons literally never change. &nbsp;They are recorded in history.</p>
<p>On the flip side, this app also shows stats up to the minute as a sports match is in progress.</p>
<p>Clearly we can't use the naive caching approach to serve both of these needs.</p>
<h2>Pulling our your HTTP Hat</h2>
<p>If you have control over the server and the client, you can take advantage of an excellent-but-not-so-well-known HTTP header called &nbsp;<span style="font-family: monospace; white-space: pre;">IF-MODIFIED-SINCE.</span></p>
<p>This is how the technique would flow:</p>
<p><img border="0" alt="IF-MODIFIED-SINCE" width="431" height="381" src="https://flux88.s3.amazonaws.com/assets/if-mod-since.png" /></p>
<p>With this scenario, we can make a request to the server very quickly, and if nothing has been changed then we simply serve up the file we have cached locally. &nbsp;We can also follow this same process for offline scenarios (just use cached data).</p>
<h2>Using a descriptor file</h2>
<p>Unfortunately, we don't always have access to have the server respond to such a header. &nbsp;Another option is to utilize a small file that is fetched at the beginning. &nbsp;We call it meta.xml, and it has the filenames &amp; dates of when the content last changed. &nbsp;This still requires at least 1 network connection at the beginning, but after that, cached data will stay on the phone's local file system until it is proven to be out of date by meta.xml.</p>
<h2>That's great, but my app still feels sluggish!</h2>
<p>iPhone apps have to have a significant amount of code written in order to make sure that applications are continually responsive (that means NO BLOCKING CODE ON THE MAIN THREAD!). &nbsp;All network operations should happen on a background thread.</p>
<blockquote><strong>Update</strong><em>: &nbsp;A friend mentioned that perhaps not ALL network operations need to happen on a background thread... you can utilize non-blocking APIs for some scenarios. &nbsp;Check out Jeff LaMarche's </em><a target="_blank" href="http://iphonedevelopment.blogspot.com/2010/05/downloading-images-for-table-without.html"><em>detailed post</em></a><em> on the topic for more information.</em>
</blockquote>
<p>In the event that cached data exists, but is proven to be out of date via one of the methods above, we can still bind the UI &amp; show some data to the user so they aren't staring at a blank screen. &nbsp; &nbsp;We can then kick off a thread to fetch the updated data and notify the UI when updated data has arrived.</p>
<p><img border="0" alt="Activity Diagram for Update &amp; Fetch" width="500" height="328" src="https://flux88.s3.amazonaws.com/assets/activity-update-and-fetch.png" /></p>
<p>You can see that this scenario is far more complicated than your simple <em>fetch the data and update</em>. &nbsp;We must use background processing and callbacks in order to keep the UI responsive. &nbsp;We immediately return cached data if it exists, so the user can be looking at a screen right away. &nbsp;Before returning, however, the repository kicks off a background thread to load the data. &nbsp;When the data comes back, the Repository sends a message to its delegate:</p>
<ul>
<li>
{% codeblock %}
didUpdateWithData:{% endcodeblock %}
</li>
<li>
{% codeblock %}
noUpdateNeeded{% endcodeblock %}
</li>
<li>
{% codeblock %}
updateFailedWithError:{% endcodeblock %}
</li>
</ul>
<p>&nbsp;</p>
<p>Armed with this architecture, we can build a UI that loads fresh data from the server only when needed, is responsive to user interaction during the remote call to fetch updated data, and will even work offline.</p>
<p>As with most things in software development (and in life)... &nbsp;doing it the easy way is easy, but doing it the right way takes some time, thought, and effort.</p>
