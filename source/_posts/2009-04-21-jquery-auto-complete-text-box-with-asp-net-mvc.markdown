--- 
layout: post
title: jQuery Auto-Complete Text Box with ASP.NET MVC
date: 2009-4-21
comments: true
link: false
---
<blockquote> <p><img alt="clip_image004" align="left" src="http://flux88.com/files/media/image/WindowsLiveWriter/ExcerptfromASP.NETMVCinActionChapter6_ED7F/clip_image004_e87da01d-98f6-479d-b891-3b4df10d5fa6.jpg"><em>This is an excerpt from Chapter 13 in my upcoming book, </em><a href="http://manning.com/palermo" target="_blank"><em>ASP.NET MVC in Action</em></a><em>.</em></p></blockquote> <p style="clear: both">_________________________________________________ <p style="clear: both">These days it is not uncommon to have text boxes automatically suggest items based on what we type. The results are further filtered as we type to give us the option to simply select an available item with the mouse or keyboard. One of the first examples of this in the wild was Google Suggest.  <p><img src="/images/clip_image002_1f1897ba-a575-4c10-8a33-bc2cdf2cb3bb.gif" alt="clip_image002"  height="415" />  <p><em><strong>Figure 13.1 Google Suggest filters options as you type </strong></em> <p>A rudimentary implementation of this would simply monitor key-presses and fire off ajax requests for each one. Of course this means that fast typist would trigger many requests, most of which would be immediately discarded for the next request coming in 5 milliseconds. A good implementation will take into account a typing delay and also provide keyboard/mouse support for selecting the items.  <p>Luckily jQuery has an extensive list of plugins available. One such plugin is Dylan Verheul’s autocomplete.  <blockquote> <p><strong>Dylan Verheul’s autocomplete</strong>  <p>You can download the autocomplete plugin at <a href="http://www.dyve.net/jquery/?autocomplete">http://www.dyve.net/jquery/</a> along with a few others including googlemaps and listify. </p></blockquote> <p>The basic idea is you have a simple text box on your page. The jQuery plugin adds the necessary behavior to handle key press events and fire the appropriate Ajax requests off to a URL that will handle the request. The URL needs point to a controller action, and by convention the response is formatted in a special way so the plugin could handle the response.  <p>Assume for our purposes that we wanted to filter US Cities in the text box. The first step is to add a controller, action, and view for displaying the UI for this example. Ensure that jquery (in this case jquery-1.2.6.js) and jquery.autcomplete.js are referenced at the top of the view (or master page). {% codeblock %}&lt;script type=<span class="str">"text/javascript"</span> src=<span class="str">"../../scripts/jquery-1.2.6.js"</span>&gt;&lt;/script&gt;
&lt;script type=<span class="str">"text/javascript"</span> src=<span class="str">"../../scripts/jquery.autocomplete.js"</span>&gt;&lt;/script&gt;{% endcodeblock %}
<p>Next, add the text box. In this example we will call it city. {% codeblock %}&lt;%= Html.TextBox(<span class="str">"city"</span>) %&gt;{% endcodeblock %}
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
<p>Package this up with a simple controller (Listing 13.1).
<p><strong>Listing 13.1 – a controller &amp; action for displaying our test page</strong> {% codeblock %}<span class="kwrd">public</span> <span class="kwrd">class</span> HomeController : Controller
{
<span class="kwrd">public</span> ActionResult Index()
{
<span class="kwrd">return</span> View();
}
}
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
<p><img src="/images/clip_image004_0cfb60e7-12e0-4a33-932e-c034304bfcc7.jpg" alt="clip_image004"  height="244" />
<p><strong><em>Figure 13.2 – Our simple view with a text box.</em></strong>
<p>Now we add a little Javascript to add the autocomplete behavior. {% codeblock %}&lt;script type=<span class="str">"text/javascript"</span>&gt;
$(document).ready(<span class="kwrd">function</span>() {
$(<span class="str">"input#city"</span>).autocomplete(<span class="str">'&lt;%= Url.Action("Find", "City") %&gt;'</span>);
});
&lt;/script&gt;
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
<p>
<p>Place this in the &lt;head&gt; of the page. You can see that the URL for the autocomplete behavior is specified as Url.Action("Find", "City"). This will point to a Find() action on the CityController. We'll need to write this controller &amp; action next.
<blockquote>
<p><strong>Local Data Mode</strong>
<p>The autocomplete plugin can also filter local data structures. This is useful when you have a limited set of data and you want to minimize requests sent to the server. The autcomplete plugin in local mode is also much faster, since there is no Ajax request happening behind the scenes. The only downside is that you must render the entire array onto the view. </p></blockquote>
<p><strong>Listing 13.3 – An action to find cities from an autocomplete ajax request</strong> {% codeblock %}<span class="kwrd">public</span> <span class="kwrd">class</span> CityController : Controller
{
<span class="kwrd">private</span> <span class="kwrd">readonly</span> ICityRepository _repository;
<span class="kwrd">public</span> CityController()
{
<span class="rem">//load up a CSV file with the city data</span>
<span class="kwrd">string</span> csvPath = Server.MapPath(<span class="str">"~/App_Data/cities.csv"</span>);
<span class="rem">//the repository reads the csv file</span>
_repository = <span class="kwrd">new</span> CityRepository(csvPath); #2
}
<span class="rem">//this constructor allows our tests to pass in a fake/mock instance</span>
<span class="kwrd">public</span> CityController(ICityRepository repository) #3
{
_repository = repository;
}
<span class="rem">//the autocomplete request sends a parameter 'q' that contains the filter</span>
<span class="kwrd">public</span> ActionResult Find(<span class="kwrd">string</span> q) #4
{
<span class="kwrd">string</span>[] cities = _repository.FindCities(q);
<span class="rem">//return raw text, one result on each line</span>
<span class="kwrd">return</span> Content(<span class="kwrd">string</span>.Join(<span class="str">"\n"</span>, cities));
}
} {% endcodeblock %}
<p>The details of the CityRepository can be found in the code samples provided with the book. For now, we will focus on the new Find(string q) action. Since this is a standard action, you can actually just navigate to it in your browser and test it out. Figure 13.3 shows a quick test.
<p><img src="/images/clip_image006_1a0c89de-76d8-4270-8354-81e3d31bde72.jpg" alt="clip_image006"  height="330" />
<p><strong><em>Listing 13.3 – A simple HTTP GET for the action with a filter of "hou" yields the expected results.</em></strong>
<p>Now that we are sure that the action is returning the correct results, we can test the textbox. The Javascript we added earlier hooks up to the keypress events on the textbox and should issue queries to the server. Figure 13.4 shows this in action.
<p><img src="/images/clip_image008_d9311a77-e166-4950-84eb-e689316fa5df.jpg" alt="clip_image008"  height="489" />
<p><strong><em>Figure 13.4 – The results are display in a &lt;ul&gt; tag. We can apply CSS to make it look nicer. </em></strong>
<p>The drop down selections are unformatted by default, which makes them a little ugly. A little CSS magic will make it look much nicer. Listing 13.4 shows some sample CSS for this.
<p><strong>Listing 13.4 – CSS used to style the autocomplete results </strong>{% codeblock %}<span class="kwrd">&lt;</span><span class="html">style</span> <span class="attr">type</span><span class="kwrd">="text/css"</span><span class="kwrd">&gt;</span>
div.ac_results ul {
margin:0;
padding:0;
list-style-type:none;
border: solid 1px #ccc;
}
div.ac_results ul li {
font-family: Arial, Verdana, Sans-Serif;
font-size: 12px;
margin: 1px;
padding: 3px;
cursor: pointer;
}
div.ac_results ul li.ac_over {
background-color: #acf;
}
<span class="kwrd">&lt;/</span><span class="html">style</span><span class="kwrd">&gt;</span>
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
<p><img src="/images/clip_image010_cdcec9f1-d7ec-460f-8c72-94b3bb9ec65b.jpg" alt="clip_image010"  height="489" />
<p><strong><em>Figure 13.5 – The styled dropdown results look much nicer. The selected item is highlighted, and can be chosen with the keyboard or the mouse. </em></strong>
<p>The auto-complete plug-in has many options for you to configure to your needs. For the simple case that we've shown here, it's as simple as this: {% codeblock %}$(your_textbox).autocomplete(<span class="str">'your/url/here'</span>); {% endcodeblock %}
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
<p>Other options for the plugin are listed below: </p>
<table border="1" cellspacing="0" cellpadding="4" width="400">
<tbody>
<tr>
<td valign="top" width="200">inputClass </td>
<td valign="top" width="200">This class will be added to the input box. </td></tr>
<tr>
<td valign="top" width="200">resultsClass </td>
<td valign="top" width="200">default value: "ac_results" </td></tr>
<tr>
<td valign="top" width="200">loadingClass </td>
<td valign="top" width="200">The class to apply to the input box while results are being fetched from the server. Default is “ac_loading.” </td></tr>
<tr>
<td valign="top" width="200">lineSeparator </td>
<td valign="top" width="200">Default is \n </td></tr>
<tr>
<td valign="top" width="200">minChars </td>
<td valign="top" width="200">The minimum # of characters before sending a request to the server. Default is 1. </td></tr>
<tr>
<td valign="top" width="200">delay </td>
<td valign="top" width="200">The delay after typing when the request will be sent. Default is 400ms. </td></tr></tbody></table>
<p>&nbsp; <p>There are many more options, but these are some common ones. To set these options, you include them in a dictionary as the second argument to the autocomplete method like this: {% codeblock %}$(<span class="str">"input#city"</span>).autocomplete(<span class="str">'&lt;%= Url.Action("Find", "City") %&gt;'</span>, {
minChars : 3,
delay : 300
});
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
<p>This type of functionality is immensely useful for selecting from large lists. It keeps your initial page size down by not loading all of these items at once and is very user-friendly.
<p>________________________________________
<p><img alt="clip_image004" align="left" src="http://flux88.com/files/media/image/WindowsLiveWriter/ExcerptfromASP.NETMVCinActionChapter6_ED7F/clip_image004_e87da01d-98f6-479d-b891-3b4df10d5fa6.jpg"><em>This is an excerpt from Chapter 13 in my upcoming book, </em><a href="http://manning.com/palermo" target="_blank"><em>ASP.NET MVC in Action</em></a><em>.</em></p>
