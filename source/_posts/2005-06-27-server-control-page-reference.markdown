--- 
layout: post
title: Server control Page reference
date: 2005-6-27
comments: true
link: false
---
<div style="clear:both;"></div><p>Why does the following code generate a null reference exception?</p><p>&nbsp;</p><br /><br /><div id="code"><br />{% codeblock %} <br /><br />public class MyServerControl : WebControl, INamingContainer<br />{<br /> private TextBox textbox1; <br /><br /> protected override CreateChildControls()<br /> {<br /> if(! Page.IsPostBack) <br /> {<br /> <span class="comments">//do stuff</span><br /> }<br /> }<br />}{% endcodeblock %}<br /></div><br />The page reference is not set. I see this sort of example all the time on the web regarding server controls. Why is it that I can not get this to work?<div style="clear:both; padding-bottom: 0.25em;"></div>
