--- 
layout: post
title: Excerpt from ASP.NET MVC in Action Chapter 6
date: 2009-4-9
comments: true
link: false
---
<p><i>Extending URL Routing in ASP.NET MVC</i>  <p>Excerpted from  <p><img src="/images/clip_image004_e87da01d-98f6-479d-b891-3b4df10d5fa6_.jpg" alt="clip_image004"  height="238" />  <p><a href="http://manning.com/palermo/">ASP.NET MVC in Action</a>  <p><img src="/images/clip_image005_1ad1421a-e8c2-4bda-8544-5d3dfff458b6_.gif" alt="clip_image005"  height="24" />  <p><b>Jeffrey Palermo, Ben Scheirman, and Jimmy Bogard</b>  <blockquote> <p>This article is taken from the book <a href="http://manning.com/palermo/">ASP.NET MVC in Action</a> from Manning Publications. One of the greatest aspects of ASP.NET MVC is its flexibility. Among other things, this gives us the capability to customize standard components. In this article, we'll take a look at how URL routing functions, and then explore how to enhance it to behave differently. For the book’s table of contents, the Author Forum, and other resources, go to <a href="http://manning.com/palermo/">http://manning.com/palermo/</a>.</p></blockquote> <p>The UrlRouteModule is an HttpModule and represents the entry point into the ASP.NET MVC Framework. This module examines each request, builds up the RouteData for the request, finds an appropriate IRouteHandler for the given route matched, and finally redirects the request to the IRouteHandler's IHttpHandler. Make sense?  <p>Our default route looks like Listing 1. The MapRoute method is actually a simplified way of specifying routes. The same route can be specified with more detail, as is shown in Listing 2.  <p><strong>Listing 1 – a simple way of specifying routes</strong></p>{% codeblock %}routes.MapRoute("default", "{controller}/{action}/{id}",
new { Controller="home", Action="index", id=""});{% endcodeblock %}
<p><strong>Listing 2 – a more detailed way of specifying routes</strong></p>{% codeblock %}routes.Add(new Route("{controller}/{action}/{id}",
new RouteValueDictionary(new { Controller = "home", Action = "index", id = "" }),
new MvcRouteHandler()));{% endcodeblock %}
<p>That third argument in Listing 2 is telling the framework which `IRouteHandler` to use for this route. We are using the built-in MvcRouteHandler that ships with the framework. By default we are using this class when using the MapRoute method. We can change this to be a custom route handler and take control in interesting ways. An IRouteHandler's responsibility is to create an appropriate IHttpHandler to handle the request given the details of the request. This is a good place to change the way routing works, or perhaps to gain control extremely early in the request pipeline. The MvcRouteHandler simply constructs an MvcHandler to handle a request, passing it a RequestContext, which contains the RouteData and IHttpContext.
<p>A quick example will help illustrate the need for a custom route handler. When starting out defining your routes, you'll sometimes run across errors. Let's assume you also have the route shown in Listing 3 defined.
<p><strong>Listing 3 – Adding another route</strong> {% codeblock %}routes.MapRoute(<span class="str">"conferenceKey"</span>, <span class="str">"{conferenceKey}/{action}"</span>,
<span class="kwrd">new</span> { Controller = <span class="str">"Conference"</span>, Action=<span class="str">"index"</span> });
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
<p>Here we’ve added a new custom route at the top position. What does it do? This will accept URLs like /HoustonCodeCamp2008/register and use the conference controller and call the register action on it, passing in the conferenceKey as a parameter to the action.
<p><strong>Listing 4 – a controller action that handles the new route </strong>{% codeblock %}<span class="kwrd">public</span> <span class="kwrd">class</span> ConferenceController : Controller
{
<span class="rem">/* snip */</span>
<span class="kwrd">public</span> ActionResult Register(<span class="kwrd">string</span> conferenceKey)
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
<p>This is a good example of a custom route that makes your URLs a lot more readable.
<p>Now let's assume that we have another controller called Home. HomeController has an index action to show the start page.
<p><strong>Listing 5 – A controller action to respond to the default route </strong>{% codeblock %}<span class="kwrd">public</span> <span class="kwrd">class</span> HomeController : Controller
{
<span class="kwrd">public</span> ActionResult Index()
{
<span class="kwrd">return</span> View();
}
<span class="rem">/* snip */</span>
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
<p>We'd like the URL for the action in Listing 4 to look like /home/index. If we try this URL, we'll get a 404 error, as shown in figure 1. Why?
<p><img src="/images/clip_image007_7c3f0a18-341c-45ed-9a52-5a5d8db8e413_.jpg" alt="clip_image007"  height="476" />
<p><strong>Figure 1 - This message doesn’t tell us much about what’s wrong. An action couldn’t be found on the controller, but which one?. </strong>
<p>It's not apparent from that error message what the problem is. We certainly have a controller called HomeController, and it has an action method called Index(). If you dig deep and take a look at the routes we can deduce that this URL was picked up by the first route, /{conferenceKey}/{action}, which was not what we intended. We should be able to indentify quickly when we have a routing mismatch, so that we can fix it more quickly.
<p>With lots of custom routes, it is easy for a URL to be caught by the wrong route. Wouldn't it be nice if we had a diagnostics tool to display which routes are being matched (and used) for quickly catching these types of errors?
<p>What we’d like to do is have an extra query string parameter that we can tack on if we want to see the route information. The current route information is stored in an object called RouteData, which is available to us in the IRouteHandler interface. The route handler is also first to get control of the request, so it is a great place to intercept and alter the behavior for any route.
<p><strong>Listing 6 – A custom route handler creates an associated IHttpHandler </strong>{% codeblock %}<span class="kwrd">public</span> <span class="kwrd">class</span> CustomRouteHandler : IRouteHandler
{
<span class="kwrd">public</span> IHttpHandler GetHttpHandler(RequestContext requestContext)
{
<span class="kwrd">if</span>(HasQueryStringKey(<span class="str">"routeInfo"</span>, requestContext.HttpContext.Request))
{
OutputRouteDiagnostics(requestContext.RouteData, requestContext.HttpContext);
}
var handler = <span class="kwrd">new</span> CustomMvcHandler(requestContext);
<span class="kwrd">return</span> handler;
}
<span class="kwrd">private</span> <span class="kwrd">bool</span> HasQueryStringKey(<span class="kwrd">string</span> keyToTest, HttpRequestBase request)
{
<span class="kwrd">return</span> Regex.IsMatch(request.Url.Query, <span class="kwrd">string</span>.Format(<span class="str">@"^\?{0}$"</span>, keyToTest));
}
<span class="rem">/* snip */</span>
} {% endcodeblock %}
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
<p>A route handler’s normal responsibility is to construct and hand-off the IHttpHandler that will handle this request. By default, this is MvcHandler. In our CustomRouteHandler we first check to see if the query string parameter is present (we do this with a simple regular expression on the URL query section). The OutputRouteDiagnostics method is shown in Listing 7.
<p><strong>Listing 7 – Rendering route diagnostics information to the response stream</strong> {% codeblock %}<span class="kwrd">private</span> <span class="kwrd">void</span> OutputRouteDiagnostics(RouteData routeData, HttpContextBase context)
{
var response = context.Response;
response.Write(
<span class="str">@"&lt;style&gt;body {font-family: Arial;}
table th {background-color: #359; color: #fff;}
&lt;/style&gt;
&lt;h1&gt;Route Data:&lt;/h1&gt;
&lt;table border='1' cellspacing='0' cellpadding='3'&gt;
&lt;tr&gt;&lt;th&gt;Key&lt;/th&gt;&lt;th&gt;Value&lt;/th&gt;&lt;/tr&gt;"</span>); <strong>#1</strong>
<span class="kwrd">foreach</span> (var pair <span class="kwrd">in</span> routeData.Values)
{
response.Write(<span class="kwrd">string</span>.Format(<span class="str">"&lt;tr&gt;&lt;td&gt;{0}&lt;/td&gt;&lt;td&gt;{1}&lt;/td&gt;&lt;/tr&gt;"</span>,
pair.Key, pair.Value));
}
response.Write(<span class="str">@"&lt;/table&gt;
&lt;h1&gt;Routes:&lt;/h1&gt;
&lt;table border='1' cellspacing='0' cellpadding='3'&gt;
&lt;tr&gt;&lt;th&gt;&lt;/th&gt;&lt;th&gt;Route&lt;/th&gt;&lt;/tr&gt;"</span>); <strong>#2</strong>
<span class="kwrd">bool</span> foundRouteUsed = <span class="kwrd">false</span>;
<span class="kwrd">foreach</span>(Route r <span class="kwrd">in</span> RouteTable.Routes)
{
response.Write(<span class="str">"&lt;tr&gt;&lt;td&gt;"</span>);
<span class="kwrd">bool</span> matches = r.GetRouteData(context) != <span class="kwrd">null</span>;
<span class="kwrd">string</span> backgroundColor = matches ? <span class="str">"#bfb"</span> : <span class="str">"#fbb"</span>; <strong>#3</strong>
<span class="kwrd">if</span>(matches &amp;&amp; !foundRouteUsed)
{
response.Write(<span class="str">"&amp;raquo;"</span>); <strong>#4</strong>
foundRouteUsed = <span class="kwrd">true</span>;
}
response.Write(<span class="kwrd">string</span>.Format(
<span class="str">"&lt;/td&gt;&lt;td style='font-family: Courier New; background-color:{0}'&gt;{1}&lt;/td&gt;&lt;/tr&gt;"</span>,
backgroundColor, r.Url));
}
response.End();
} {% endcodeblock %}
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
<p><em>1. Create an HTML table to display the route values for the current request. <br>2. Create an HTML table to display the routes <br>3. Green if it matches, Red if it doesn't <br>4. Places a chevron character (») next to the route selected for the request </em></p>
<p>This method outputs two tables, one for the current route data, and one for the routes in the system. Each route will return null for GetRouteData if the route doesn’t match the current request. The table is then colored to show which routes matched, and a little arrow indicates which route is the one in use for the current URL. The response is then ended to prevent any further rendering.
<p>To finalize this change, we have to alter the current routes to use our new handler.
<p><strong>Listing 8 – Assigning routes to our custom route handler </strong>{% codeblock %}RouteTable.Routes.Add(
<span class="kwrd">new</span> Route(<span class="str">"{conferenceKey}/{action}"</span>,
<span class="kwrd">new</span> RouteValueDictionary( <span class="kwrd">new</span> { Controller=<span class="str">"Conference"</span> }),
<span class="kwrd">new</span> CustomRouteHandler()));
RouteTable.Routes.Add(
<span class="kwrd">new</span> Route(<span class="str">"{controller}/{action}/{id}"</span>,
<span class="kwrd">new</span> RouteValueDictionary( <span class="kwrd">new</span> { Action=<span class="str">"Index"</span>, id=(<span class="kwrd">string</span>)<span class="kwrd">null</span> }),
<span class="kwrd">new</span> CustomRouteHandler()));
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
<p>The end result (shown in Listing 2) is incredibly helpful. Let’s use the /home/index URL (that resulted in a 404 in Listing 1) but this time we’ll add the ?routeInfo to the query string. We can see in the route data table that the value “home” was picked up as a conference key, as shown in figure 2. The route table confirms that the conference key route was picked up first, since it matched.
<p><img src="/images/clip_image009_09a4468a-13c8-4b55-8ff9-41601fe8f767_.jpg" alt="clip_image009"  height="480" />
<p><strong>Listing 2 – appending ?routeInfo gives us detailed information about the current request’s route. We can easily see now that the wrong route was chosen. </strong>
<p>Now you can immediately tell that the current route used is not the one we intended. We can also tell whether or not other routes match this request by the color of the cell: Both of the rows are green. We now quickly identify the issue as a routing problem and can fix it accordingly. In this case, if we add constraints to the first route such that conferenceKey isn’t the same as one of our controllers, the problem is resolved. Remember that order matters! The first route matched is the one used.
<p>Of course you wouldn’t want this information to be visible in a deployed application, so only use to aid your development. You could also build a switch that changes the routes to the CustomRouteHandler if you’re in debug mode, which would be a more automated solution. I’ll leave this as an exercise for the reader.
<blockquote>
<p><strong>Inspired by Phil Haack’s Route Debugger </strong>
<p>This example was inspired by Phil Haack’s route debugger that he posted on his blog when the ASP.NET MVC Framework was in Preview 2. It is a great example of what you can do with the information provided to you by the routing system. You can see his original example of this here:
<p><a href="http://haacked.com/archive/2008/03/13/url-routing-debugger.aspx">http://haacked.com/archive/2008/03/13/url-routing-debugger.aspx</a>. </p></blockquote>
<p>Another potential use of a custom route handler would be to append a specific identifier to the query string automatically. This could be useful in scenarios where you rely on cookie-less sessions or maybe you have a company identifier that limits what is displayed on the screen (your author has interfaced with such a framework). An IHttpHandler that would satisfy this requirement might look like this:
<p><strong>Listing 9 – An MvcHandler that can enforce query string parameters</strong> {% codeblock %}<span class="kwrd">public</span> <span class="kwrd">class</span> EnsureCompanyKeyHandler : MvcHandler
{
<span class="kwrd">public</span> EnsureCompanyKeyHandler(RequestContext requestContext)
: <span class="kwrd">base</span>(requestContext)
{
}
<span class="kwrd">protected</span> <span class="kwrd">override</span> <span class="kwrd">void</span> ProcessRequest(HttpContextBase context)
{
var controller = (<span class="kwrd">string</span>) RequestContext.RouteData.Values[<span class="str">"controller"</span>];
var company = context.Request.QueryString[<span class="str">"company"</span>];
<span class="kwrd">if</span> (controller != <span class="str">"login"</span> &amp;&amp; company == <span class="kwrd">null</span>)
{
context.Response.Redirect(<span class="str">"~/login"</span>); <strong>#1</strong>
}
<span class="kwrd">else</span>
{
<span class="kwrd">base</span>.ProcessRequest(context); <strong>#2</strong>
}
}
} {% endcodeblock %}
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
<p><em>1. Force them to login <br>2. The URL contains a company key, so we can continue </em>
<p>In this example, every request must have a company key. The ProcessRequest method will not continue unless the URL contains this.
<p>Hopefully you noticed how easy it was to extend the framework. Since most of the objects that you interact with are either interfaces or abstract base classes, it allows you to completely (or almost completely) substitute behavior for your own. It is in this level of flexibility where you will see the ASP.NET MVC Framework really shine.</p>
<blockquote>
<p>This article is taken from the book <a href="http://manning.com/palermo/">ASP.NET MVC in Action</a> from Manning Publications.</p></blockquote>
