--- 
layout: post
title: Changing log4net connection string at runtime
date: 2009-12-3
comments: true
link: false
---
<p>On my current project, we log with log4net.&#160; This project is still kicking, and I still love using it.&#160; It is a bit dated though, and there are things that probably should work out of the box, but just don’t.</p>  <p>One of those things is the AdoNetAppender’s connection string.&#160; There’s no built-in way of making this use a connection string from your &lt;connectionStrings&gt; section of your config file.</p>  <p>I came across <a href="http://weblogs.asp.net/drnetjes/archive/2005/02/16/374780.aspx" target="_blank">this post</a>, which helped me solve the problem, but the post is 4 years old and the code sample didn’t quite work.&#160; </p>  <p>Here is an updated snippet that does work with the latest version of log4net:</p>  {% codeblock %}public static void SetAdoNetAppenderConnectionStrings(string connectionStringKey)
{
var hier = (Hierarchy)LogManager.GetRepository();
if (hier != null)
{
var appenders = hier.GetAppenders().OfType<adonetappender>();
foreach (var appender in appenders)
{
appender.ConnectionString = ConfigurationManager.ConnectionStrings[connectionStringKey].ConnectionString;
appender.ActivateOptions();
}
}
}{% endcodeblock %}
<p>That works nicely, and allows me to remove the connectionString element from the AdoNetAppender’s configuration.</p>
<p><em>One small caveat:&#160; log4net tries to open the connection at runtime to make sure the database connection string is valid.&#160; You’ll see a message like “<strong>Unable to open a database connection to []</strong>” which you can safely ignore.&#160; If it really bothers you, then you can add a valid connection string here, but that sort of defeats the purpose of DRY.</em></p>
