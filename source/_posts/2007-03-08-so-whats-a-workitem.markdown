--- 
layout: post
title: So What's a WorkItem?
date: 2007-3-8
comments: true
link: false
---
<p>Probably the largest single piece that you need to understand about CAB is the WorkItem.</p><p>As I mentioned before, WorkItems are usually 1:1 with use cases.&nbsp; For example, say we are buiding a CRM product, we might have a use case called &ldquo;Edit Customer.&rdquo;&nbsp; This would map to an EditCustomerWorkItem.</p><p>Think of the WorkItem as a container for anything related to the use case.&nbsp; It can house various elements such as UI components, state, services, etc.&nbsp; This gives you a nice boundary for when things get instantiated or destructed.</p><p>WorkItems live inside of modules, and are instantiated by the ModuleInit class. </p><p>So say, given the example above, we have loaded our CustomerInformationModule, which contains an EditCustomerWorkItem.&nbsp; The workitem might contain:</p><ul><li>A reference to a customer object, or customer id</li><li>A service used to retrieve/save the customer</li><li>A controller for implementing UI logic and interacting with our customer object</li><li>A view (control) that displays the various controls necessary to complete the use case.&nbsp; It might have some textboxes, a Save button and a Delete button.</li></ul><p>If you don&rsquo;t do your use case homework, your work items will &ldquo;go against the grain&rdquo; of the application and add unnecessary complexity to the whole framework.&nbsp; Do your use case work up front, and you&rsquo;ll be designing better WorkItems.</p>
