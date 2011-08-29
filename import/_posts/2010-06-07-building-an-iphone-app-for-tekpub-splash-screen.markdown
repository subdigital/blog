--- 
layout: post
title: Building an iPhone App for Tekpub - Splash Screen
date: 2010-6-7
comments: true
link: false
---
<p>I hope that many of you have watched the <a href="http://tekpub.com/production/iphone">iPhone Development series</a> over at <a href="http://tekpub.com">Tekpub</a> by yours truly.  To wrap up the series, Rob and I wanted to show you exactly what is required to get an ad-hoc build out for beta testers, how to get a certificate from Apple in order to code-sign your application, and finally how to submit it to the App Store.</p>
<p>In the end, we'll be submitted the actual official Tekpub iPhone application, which I am currently building as I type this.  I plan on posting about some of the interesting bits as I go.  So on that note....</p>
<h2>Building a Splash Screen</h2>
<p>Any iPhone app that requires data off of the network in order to function will require some up front loading cost.  After all, <a href="http://flux88.com/blog/iphone-apps-don-t-live-in-a-vacuum/">iPhone apps don't live in a vacuum</a>.</p>
<p>You might think of simply adding some network code into the applicationDidFinishLaunching: event, however this would cause problems.  Though strangely missing from the official documentation, it is known that the <a href="http://stackoverflow.com/questions/169470/does-the-iphone-timeout-if-a-function-takes-too-long-to-execute">iPhone OS will kill an application if appears to hang for more than a couple seconds</a>.  So it is imperative to utilize asynchronous operations in order to load up the data that is needed.</p>
<p>A good place to do that is a splash screen.  Instead of using one of the application templates for Tab Bar or Navigation-Based application, I chose to simply utilize a View Based application template.  This is because while the splash screen is visible, there shouldn't be any tabs or toolbars.</p>
<p>The root controller is called SplashScreenController.  It handles the asynchronous data loading, utilizes a progress bar so it doesn't feel like the app is doing nothing, and notifies the Application Delegate once it is done loading.</p>
{% codeblock %}<span style="font-family: Menlo; font-size: 11px;"><span style="color: #b930a1;">@implementation</span> SplashScreenController</span>{% endcodeblock %}
{% codeblock %}<br />{% endcodeblock %}
{% codeblock %}-(<span style="color: #b930a1;">void</span>)viewDidLoad {{% endcodeblock %}
{% codeblock %}<span style="color: #000000;"><span style="white-space: pre;"> </span></span><span style="color: #7140a7;">UIProgressView</span><span style="color: #000000;"> *progressView = [[[</span><span style="color: #7140a7;">UIProgressView</span><span style="color: #000000;"> </span>alloc<span style="color: #000000;">] </span>initWithProgressViewStyle<span style="color: #000000;">:</span>UIProgressViewStyleBar<span style="color: #000000;">] </span>autorelease<span style="color: #000000;">];</span>{% endcodeblock %}
{% codeblock %}<span style="white-space: pre;"> </span><span style="color: #b930a1;">int</span> width = <span style="color: #3031d5;">200</span>;{% endcodeblock %}
{% codeblock %}<span style="white-space: pre;"> </span>progressView.<span style="color: #7140a7;">frame</span> = <span style="color: #3e217f;">CGRectMake</span>((<span style="color: #3031d5;">320</span>-width)/<span style="color: #3031d5;">2</span>, (<span style="color: #3031d5;">480</span>-<span style="color: #3031d5;">10</span>)/<span style="color: #3031d5;">2</span> + <span style="color: #3031d5;">20</span>, width, <span style="color: #3031d5;">10</span>);{% endcodeblock %}
{% codeblock %}<span style="white-space: pre;"> </span>[<span style="color: #b930a1;">self</span>.<span style="color: #7140a7;">view</span> <span style="color: #3e217f;">addSubview</span>:progressView];{% endcodeblock %}
{% codeblock %}<span style="white-space: pre;"> </span>{% endcodeblock %}
{% codeblock %}<span style="white-space: pre;"> </span><span style="color: #7140a7;">UILabel</span> *label = [[[<span style="color: #7140a7;">UILabel</span> <span style="color: #3e217f;">alloc</span>] <span style="color: #3e217f;">initWithFrame</span>:<span style="color: #3e217f;">CGRectMake</span>((<span style="color: #3031d5;">320</span>-width)/<span style="color: #3031d5;">2</span>, (<span style="color: #3031d5;">480</span>-<span style="color: #3031d5;">10</span>)/<span style="color: #3031d5;">2</span>, width, <span style="color: #3031d5;">20</span>)] <span style="color: #3e217f;">autorelease</span>];{% endcodeblock %}
{% codeblock %}<span style="white-space: pre;"> </span>label.<span style="color: #7140a7;">font</span> = [<span style="color: #7140a7;">UIFont</span> <span style="color: #3e217f;">fontWithName</span>:<span style="color: #ce2f24;">@"Courier"</span> <span style="color: #3e217f;">size</span>:<span style="color: #3031d5;">12</span>];{% endcodeblock %}
{% codeblock %}<span style="color: #000000;"><span style="white-space: pre;"> </span>label.</span>backgroundColor<span style="color: #000000;"> = [</span>UIColor<span style="color: #000000;"> </span><span style="color: #3e217f;">clearColor</span><span style="color: #000000;">];</span>{% endcodeblock %}
{% codeblock %}<span style="color: #000000;"><span style="white-space: pre;"> </span>label.</span>textColor<span style="color: #000000;"> = [</span>UIColor<span style="color: #000000;"> </span><span style="color: #3e217f;">darkGrayColor</span><span style="color: #000000;">];</span>{% endcodeblock %}
{% codeblock %}<span style="color: #000000;"><span style="white-space: pre;"> </span>label.</span><span style="color: #7140a7;">textAlignment</span><span style="color: #000000;"> = </span>UITextAlignmentCenter<span style="color: #000000;">;</span>{% endcodeblock %}
{% codeblock %}<span style="color: #000000;"><span style="white-space: pre;"> </span>label.</span><span style="color: #7140a7;">text</span><span style="color: #000000;"> = </span>@"Preparing the awesome ..."<span style="color: #000000;">;</span>{% endcodeblock %}
{% codeblock %}<span style="white-space: pre;"> </span>[<span style="color: #b930a1;">self</span>.<span style="color: #7140a7;">view</span> <span style="color: #3e217f;">addSubview</span>:label];{% endcodeblock %}
{% codeblock %}<span style="white-space: pre;"> </span>{% endcodeblock %}
{% codeblock %}<span style="color: #000000;"><span style="white-space: pre;"> </span></span>proxy<span style="color: #000000;"> = [[</span>TekpubProxy<span style="color: #000000;"> </span><span style="color: #3e217f;">alloc</span><span style="color: #000000;">] </span><span style="color: #3e217f;">init</span><span style="color: #000000;">];</span>{% endcodeblock %}
{% codeblock %}<span style="color: #000000;"><span style="white-space: pre;"> </span></span><span style="color: #518187;">proxy</span><span style="color: #000000;">.</span>delegate<span style="color: #000000;"> = </span><span style="color: #b930a1;">self</span><span style="color: #000000;">;</span>{% endcodeblock %}
{% codeblock %}<span style="color: #000000;"><span style="white-space: pre;"> </span></span>proxy<span style="color: #000000;">.</span>progressDelegate<span style="color: #000000;"> = progressView;</span>{% endcodeblock %}
{% codeblock %}<span style="color: #000000;"><span style="white-space: pre;"> </span>[</span><span style="color: #518187;">proxy</span><span style="color: #000000;"> </span>asyncUpdateProductions<span style="color: #000000;">];</span>{% endcodeblock %}
{% codeblock %}}{% endcodeblock %}
{% codeblock %}<br />{% endcodeblock %}
{% codeblock %}- (<span style="color: #b930a1;">void</span>)doneUpdatingProductions {{% endcodeblock %}
{% codeblock %}<span style="color: #000000;"><span style="white-space: pre;"> </span></span><span style="color: #518187;">proxy</span><span style="color: #000000;">.</span>delegate<span style="color: #000000;"> = </span><span style="color: #b930a1;">nil</span><span style="color: #000000;">;</span>{% endcodeblock %}
{% codeblock %}<span style="color: #000000;"><span style="white-space: pre;"> </span></span>proxy<span style="color: #000000;">.</span>progressDelegate<span style="color: #000000;"> = </span><span style="color: #b930a1;">nil</span><span style="color: #000000;">;</span>{% endcodeblock %}
{% codeblock %}<span style="color: #000000;"><span style="white-space: pre;"> </span>[</span><span style="color: #518187;">proxy</span><span style="color: #000000;"> </span>release<span style="color: #000000;">];</span>{% endcodeblock %}
{% codeblock %}<br />{% endcodeblock %}
{% codeblock %}<span style="white-space: pre;"> </span><span style="color: #518187;">tekpubAppDelegate</span> *appDelegate = (<span style="color: #518187;">tekpubAppDelegate</span> *)[[<span style="color: #7140a7;">UIApplication</span> <span style="color: #3e217f;">sharedApplication</span>] delegate];{% endcodeblock %}
{% codeblock %}<span style="white-space: pre;"> </span>[appDelegate <span style="color: #33595d;">doneLoading</span>];{% endcodeblock %}
{% codeblock %}}{% endcodeblock %}
{% codeblock %}<br />{% endcodeblock %}
{% codeblock %}- (<span style="color: #b930a1;">void</span>)failedUpatingProductions {{% endcodeblock %}
{% codeblock %}<span style="color: #000000;"><span style="white-space: pre;"> </span></span>UIAlertView<span style="color: #000000;"> *alert = [[[</span>UIAlertView<span style="color: #000000;"> </span><span style="color: #3e217f;">alloc</span><span style="color: #000000;">] </span><span style="color: #3e217f;">initWithTitle</span><span style="color: #000000;">:</span><span style="color: #ce2f24;">@"Error connecting!"</span>{% endcodeblock %}
{% codeblock %}<span style="color: #000000;"><span style="white-space: pre;"> </span> </span><span style="color: #3e217f;">message</span><span style="color: #000000;">:</span>@"We couldn't fetch the `awesome` from tekpub.com.  Are you connected to the internet?"{% endcodeblock %}
{% codeblock %}<span style="color: #000000;"><span style="white-space: pre;"> </span></span>delegate<span style="color: #000000;">:</span><span style="color: #b930a1;">nil</span><span style="color: #000000;"> </span>{% endcodeblock %}
{% codeblock %}<span style="color: #000000;"> </span>cancelButtonTitle<span style="color: #000000;">:</span><span style="color: #ce2f24;">@"OK"</span><span style="color: #000000;"> </span>otherButtonTitles<span style="color: #000000;">:</span><span style="color: #b930a1;">nil</span><span style="color: #000000;">] </span>autorelease<span style="color: #000000;">];</span>{% endcodeblock %}
{% codeblock %}<span style="white-space: pre;"> </span>[alert <span style="color: #3e217f;">show</span>];{% endcodeblock %}
{% codeblock %}}{% endcodeblock %}
{% codeblock %}<br />{% endcodeblock %}
{% codeblock %}<br />{% endcodeblock %}
{% codeblock %}@end{% endcodeblock %}
<p>The first few lines of code simply set up some UI elements that weren't part of the NIB file.  Doing it this way is certainly a matter of preference, and I find that occasionally building UI controls is easier than in Interface Builder.</p>
<p>Next up, we kick off the async process via a separate class called TekpubProxy.  This class utilizes the excellent <a href="http://allseeing-i.com/ASIHTTPRequest/">ASIHTTPRequest</a> library to do easy asynchronous network requests, complete with progress callbacks.  A bonus is that the progressDelegate automatically detects when you set it to a UIProgressView and automatically updates the status.  <em>How cool is that?! </em></p>
<p>Finally, when the splash screen is notified that the loading has completed, we call a method on the App Delegate in order to proceed with the rest of the application.</p>
<p>Here is the AppDelegate class:</p>
{% codeblock %}<span style="font-family: Menlo; font-size: 11px;"><span style="color: #b930a1;">@implementation</span> tekpubAppDelegate</span>{% endcodeblock %}
{% codeblock %}<br />{% endcodeblock %}
{% codeblock %}@synthesize<span style="color: #000000;"> window;</span>{% endcodeblock %}
{% codeblock %}<span style="color: #b930a1;">@synthesize</span> splashScreenController;{% endcodeblock %}
{% codeblock %}<br />{% endcodeblock %}
{% codeblock %}<br />{% endcodeblock %}
{% codeblock %}- (<span style="color: #b930a1;">void</span>)applicationDidFinishLaunching:(<span style="color: #7140a7;">UIApplication</span> *)application {{% endcodeblock %}
{% codeblock %}<br />{% endcodeblock %}
{% codeblock %}<span style="color: #000000;"> </span>// Add the tab bar controller's current view as a subview of the window{% endcodeblock %}
{% codeblock %}<span style="color: #000000;"> [</span>window<span style="color: #000000;"> </span><span style="color: #3e217f;">addSubview</span><span style="color: #000000;">:</span>splashScreenController<span style="color: #000000;">.</span><span style="color: #3e217f;">view</span><span style="color: #000000;">];</span>{% endcodeblock %}
{% codeblock %}}{% endcodeblock %}
{% codeblock %}<br />{% endcodeblock %}
{% codeblock %}-(<span style="color: #b930a1;">void</span>)doneLoading {{% endcodeblock %}
{% codeblock %}<span style="white-space: pre;"> </span>{% endcodeblock %}
{% codeblock %}<span style="color: #000000;"><span style="white-space: pre;"> </span></span>ProductionsController<span style="color: #000000;"> *controller = [[</span>ProductionsController<span style="color: #000000;"> </span><span style="color: #3e217f;">alloc</span><span style="color: #000000;">] </span><span style="color: #3e217f;">initWithStyle</span><span style="color: #000000;">:</span><span style="color: #3e217f;">UITableViewStylePlain</span><span style="color: #000000;">];</span>{% endcodeblock %}
{% codeblock %}<span style="color: #000000;"><span style="white-space: pre;"> </span></span><span style="color: #518187;">navController</span><span style="color: #000000;"> = [[</span><span style="color: #7140a7;">UINavigationController</span><span style="color: #000000;"> </span>alloc<span style="color: #000000;">] </span>initWithRootViewController<span style="color: #000000;">:controller];</span>{% endcodeblock %}
{% codeblock %}<span style="color: #000000;"><span style="white-space: pre;"> </span></span><span style="color: #518187;">navController</span><span style="color: #000000;">.</span>navigationBar<span style="color: #000000;">.</span>tintColor<span style="color: #000000;"> = [</span>UIColor<span style="color: #000000;"> </span><span style="color: #3e217f;">blackColor</span><span style="color: #000000;">];</span>{% endcodeblock %}
{% codeblock %}<span style="white-space: pre;"> </span>{% endcodeblock %}
{% codeblock %}<span style="color: #000000;"><span style="white-space: pre;"> </span>[</span>window<span style="color: #000000;"> </span><span style="color: #3e217f;">insertSubview</span><span style="color: #000000;">:</span>navController<span style="color: #000000;">.</span><span style="color: #7140a7;">view</span><span style="color: #000000;"> </span><span style="color: #3e217f;">belowSubview</span><span style="color: #000000;">:</span>splashScreenController<span style="color: #000000;">.</span><span style="color: #3e217f;">view</span><span style="color: #000000;">];</span>{% endcodeblock %}
{% codeblock %}<span style="white-space: pre;"> </span>{% endcodeblock %}
{% codeblock %}<span style="color: #000000;"><span style="white-space: pre;"> </span>[</span><span style="color: #7140a7;">UIView</span><span style="color: #000000;"> </span>beginAnimations<span style="color: #000000;">:</span><span style="color: #ce2f24;">@"fadeIn"</span><span style="color: #000000;"> </span>context<span style="color: #000000;">:</span><span style="color: #b930a1;">nil</span><span style="color: #000000;">];</span>{% endcodeblock %}
{% codeblock %}<span style="color: #000000;"><span style="white-space: pre;"> </span>[</span><span style="color: #7140a7;">UIView</span><span style="color: #000000;"> </span>setAnimationDuration<span style="color: #000000;">:</span><span style="color: #3031d5;">1.5</span><span style="color: #000000;">];</span>{% endcodeblock %}
{% codeblock %}<span style="color: #000000;"><span style="white-space: pre;"> </span></span>splashScreenController<span style="color: #000000;">.</span><span style="color: #7140a7;">view</span><span style="color: #000000;">.</span><span style="color: #7140a7;">alpha</span><span style="color: #000000;"> = </span><span style="color: #3031d5;">0</span><span style="color: #000000;">;</span>{% endcodeblock %}
{% codeblock %}<br />{% endcodeblock %}
{% codeblock %}<span style="color: #000000;"><span style="white-space: pre;"> </span>[</span><span style="color: #7140a7;">UIView</span><span style="color: #000000;"> </span>commitAnimations<span style="color: #000000;">];</span>{% endcodeblock %}
{% codeblock %}<span style="white-space: pre;"> </span>{% endcodeblock %}
{% codeblock %}<span style="white-space: pre;"> </span>[controller <span style="color: #3e217f;">release</span>];{% endcodeblock %}
{% codeblock %}}{% endcodeblock %}
{% codeblock %}<span style="font-family: Menlo; font-size: small;"><span style="font-size: 11px;">﻿</span></span>{% endcodeblock %}
{% codeblock %}<span style="font-family: Menlo; font-size: small;"><span style="font-size: 11px;"><span style="color: #b930a1;">@end</span></span></span>{% endcodeblock %}
<p>We utilize a nice cross-fade animation to bring the navigation controller stack into view.  The end result is quite nice, and makes the 2-3 second loading time much more bearable.</p>
<p><span style="color: #b930a1; font-family: Menlo; font-size: small;"><span style="font-size: 11px;"> <img src="https://flux88.s3.amazonaws.com/images/tekpub-splash.png" alt="tekpub-splash-screen" /></span></span></p>
