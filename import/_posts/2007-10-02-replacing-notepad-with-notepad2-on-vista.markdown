--- 
layout: post
title: Replacing Notepad with Notepad2 on Vista
date: 2007-10-2
comments: true
link: false
---
<p>I hadn&rsquo;t ever gotten around to replacing Notepad with the most-excellent <a href="http://www.flos-freeware.ch/notepad2.html" target="_blank">Notepad2</a> until today and realized that the method outlined in <a href="http://www.flux88.com/ReplaceNotepadCompletely.aspx">my older post</a> <strong>doesn&rsquo;t</strong> <strong>work in Windows Vista</strong> due to heightened security.</p><p>To replace it on Vista, follow these steps:</p><ol><li>Download <a href="http://www.flos-freeware.ch/notepad2.html" target="_blank">Notepad2</a> and put it in a folder somewhere like C:\tools\Notepad2</li><li>In Windows Explorer, navigate to C:\Windows\System32</li><li>Right-click on notepad.exe and go to Properties</li><li>Under the security tab, click Advanced.</li><li>Change the owner to MACHINE\Administrators</li><li>Close and re-open the properties box.</li><li>Go back to the security tab and click &ldquo;Edit&rdquo;</li><li>Give the Administrators group Full Control over the file.</li><li>Now go to a command prompt and type this:<br />copy c:\windows\system32\notepad.exe c:\windows\system32\notepad.exe.old<br />copy c:\tools\notepad2\notepad2.exe c:\windows\system32\notepad.exe</li></ol><p>Voila!&nbsp; Now you should be back in business.</p><p>Now I&rsquo;m back to wondering why they didn&rsquo;t just make Notepad better in the first place&hellip;</p>
