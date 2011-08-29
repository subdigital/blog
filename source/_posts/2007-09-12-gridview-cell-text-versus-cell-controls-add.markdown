--- 
layout: post
title: GridView Cell.Text Versus Cell.Controls.Add
date: 2007-9-12
comments: true
link: false
---
I'm sure I've come across this before, but I'm writing this down so that I don't forget it later.<br/><br/>I'm working with a pretty hefty custom GridView and it's really trying my patience for this control.&nbsp; Yeah yeah, it's all great if you want to bind a list of data coming from a SQL Query written in your aspx in plain-text.&nbsp; The minute you start to customize it all that goodness turns into a mess of weird templating and strange quirks about ASP.NET, but I digress.<br/><br/>Anyway, this post relates to the fact that the TableCell class has a Text property <i>and</i> a controls collection.<br/><br/>If you are creating custom rows of data, you have to choose between doing <br/>{% codeblock %}cell.Text = "content";{% endcodeblock %}or <br />{% codeblock %}cell.Controls.Add( new LiteralControl("content") );{% endcodeblock %}The difference is that the two are mutually exclusive.&nbsp; If you have controls inside the table cell, then the Text property will be empty.&nbsp; If you have the Text property set, then there can't be any controls.<br /><br/>So in my case I was setting the Text property, then trying to insert a LinkButton control right <i>before</i> the text.&nbsp; So I diligently put <br/>{% codeblock %}row.Cells[index].Controls.AddAt(0, theLinkButton);{% endcodeblock %}Which happily wipes everything that was previously in the Text property.&nbsp; Ugh.
