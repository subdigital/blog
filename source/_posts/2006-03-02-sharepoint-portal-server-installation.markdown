--- 
layout: post
title: Sharepoint Portal Server Installation
date: 2006-3-2
comments: true
link: false
---
I was installing Sharepoint Portal Server 2003 at a client site this week.&nbsp; During and after the install we were getting very strange errors, eventually leaving the site useless until we could figure them out.&nbsp; Installing WSS Service Pack 2 and SPS Service Pack 2 helped get through the installation, but even after the site was completely installed, we still received lots of errors.<br><br>It turns out that IIS didn't have script maps for ASP.NET 1.1, so only 2.0 showed up in the list.&nbsp; Though the updates are supposed to work with 2.0, my experience tells me otherwise.&nbsp; Sharepoint Portal Server 2003 *definitely* has issues if you run it in 2.0.&nbsp; To add the option for 1.1 in IIS, you can run:<br>{% codeblock %}c:\windows\Microsoft .NET\Framework\v1.1433\aspnet_regiis -i<br>{% endcodeblock %}This will reinstall the script maps for that version into IIS.&nbsp; I changed the SPS site to use 1.1,&nbsp; but I still received errors.&nbsp; <br><br>A reinstall put the site back on 2.0, which was quite odd...&nbsp; I got the same errors as before.&nbsp; Finally, to fix it I <i>disabled</i> 2.0 in IIS 6.0's Web Service Extensions section.&nbsp; Then I reinstalled SPS, which was then forced to use 1.1.&nbsp; All was well with the world after that...<br>
