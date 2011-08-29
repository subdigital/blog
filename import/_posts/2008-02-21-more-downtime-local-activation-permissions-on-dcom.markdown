--- 
layout: post
title: More Downtime - Local Activation Permissions on DCOM
date: 2008-2-21
comments: true
link: false
---
What luck.&nbsp; My server went down last night and didn't come back up until this morning.&nbsp; I eventually had to request a power cycle from my host and then remote desktop in to see what went wrong.<br><br>The root cause of the error was this:<br><br>The application-specific permission settings do not grant Local Activation permission for the COM Server application with CLSID ...... to the user NT AUTHORITY\NETWORK SERVICE.<br><br>This caused a few other errors to occur in rapid succession and Windows decided to shut down my application pool.&nbsp; You can clearly see the issue here:<br><br><img src=""><br><p></p><img src="http://flux88.com/content/binary/server-error.png" border="0"><br><br>I read up on the error and found a solution.&nbsp; Apparently after Server 2003 SP1 came out, this issue started appearing on servers with a specific Group Policy (I'm not sure what).&nbsp; They suggested to add NETWORK SERVICE to the DCOM Users group.<br><br>So far it is working fine.&nbsp; We'll see!<br><br>I wonder how much <a href="http://www.faqs.org/docs/jargon/G/google-juice.html">google juice</a> I lost during the 12 hour outage.&nbsp; :(<br>
