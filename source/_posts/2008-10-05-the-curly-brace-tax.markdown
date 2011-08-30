--- 
layout: post
title: The Curly Brace Tax
date: 2008-10-5
comments: true
link: false
---
<em>(I shamelessly stole this title from a chat with <a href="http://mhinze.com/" target="_blank">Matt Hinze</a>)</em>

99% of the examples you see out there for ASP.NET MVC are using WebFormsViewEngine.  That's fine, it's familiar, it benefits from intellisense, compilation, and refactoring support.  But all of that comes at a price, and that price is (at times) <strong>incredibly wordy</strong>.

Picture this example, taken from the Site.master (master page) in the Preview 5 new project template.

At the top of the page, they want to render some text if the user is logged in, and different text if the user isn't logged in.  Here are the screens:

**When you're not logged in:**

<img src="/images/mvcmasterpagelogin_thumb.jpg" alt="mvc-masterpage-login"  border="0"  />

**And when you're logged in...**

<img src="/images/mvcmasterpagelogout_thumb.jpg" alt="mvc-masterpage-logout"  border="0"  />

This is implemented using ASPX code that looks like this:

{% codeblock %}
<div id="logindisplay">
  <% if (Request.IsAuthenticated) { %>
    Welcome <b><%= Html.Encode(Page.User.Identity.Name) %></b>![ <%=Html.ActionLink("Logout", "Logout", "Account") %> ]
<% } else { %> 
    [ <%=Html.ActionLink("Login", "Login", "Account") %> ]
<% } %>
</div>

{% endcodeblock %}

Now let's take the same example and convert it to <a href="http://velocity.apache.org/engine/releases/velocity-1.5/user-guide.html" target="_blank">NVelocity</a>, another view engine with a looser syntax:

{% codeblock %}
<div id="logindisplay">	
  #if ($isAuthenticated)
    Welcome <b>$html.encode($user.name)</b>!		[ $html.actionlink("Logout", "logout", "account") ]
  #else
    [ $html.actionlink("Login", "login", "account") ]	#end
</div>
{% endcodeblock %}

We'd have to stuff the `$isAuthenticated` and `$user` values into `ViewData`, but that's a piece of cake.  
This is a great example of how concise we can get if we don't rely on all that strong typing.  

<em>The beauty of this is, the key that you use for ViewData becomes the object you interact with on the view</em>.

In NVelocity:

* case doesn't matter
* no need to open up `<% %>` tags, you can embed it directly in your template
* type doesn't matter.  It's evaluated at runtime.

There are some downsides, however:

* You don't get compile time checking for your views.  If I wrote `$htlm.actionlink(..)`  I'd get an 
error at runtime.

* Performance.  Compiled views are much faster than interpreted ones.  It's likely that this doesn't matter for most sites out there.

* No intellisense.  (The arguments to ActionLink above are not obvious, so you just have to memorize it)
* **No Refactoring support**.  This is a big one.  If you rename your actions, you'll have to do a string comparison search to get the various links you might having lying around in your view.

That last one is really the only one that I miss when doing something in NVelocity.  In any case, try it out, see what you think!
