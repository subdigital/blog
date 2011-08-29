--- 
layout: post
title: What's in a CAB Module?
date: 2007-3-7
comments: true
link: false
---
<p>One of the root components of a CAB Application is the module.&nbsp; So what is a module, exactly?</p><p>A Module is basically a collection of WorkItems.&nbsp; Since WorkItems are generally 1:1 with use cases, then modules are a package for related use cases.</p><p><img src="/images/modules.gif" alt="Modules"  border="1"  /></p><p>Modules get loaded by the application Shell, via the ProfileCatalog.xml file.&nbsp; When you are structuring your solution, <strong>you do not include a project reference to the module project in your shell project</strong>.</p><p>One benefit of doing this is that you can create new modules and load them into a shell without recompiling the main shell solutions.&nbsp; You could easily package up a patch which included a new ProfileCatalog.xml and a dll as a zip file.</p><p>Modules also help you organize your WorkItems into logical units so that they become more managable.</p><p>&nbsp;</p>
