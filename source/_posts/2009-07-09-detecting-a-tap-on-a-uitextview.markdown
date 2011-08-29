--- 
layout: post
title: Detecting a tap on a UITextView
date: 2009-7-9
comments: true
link: false
---
<p>I&rsquo;ve been working on a little side project (that I&rsquo;ll announce soon).&nbsp; It is an iPhone application that I intend to sell.&nbsp; Being a .NET guy, I&rsquo;m certainly a bit lost when it comes to troubleshooting problems with Objective-C and Cocoa.&nbsp; Hopefully this post will help someone else out that ran into a similar issue.</p>
<p>In Cocoa, any class that derives from UIResponder (which means UIView and all of it&rsquo;s subclasses) can get touch events by implementing these 4 optional methods:</p>
{% codeblock %}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;{% endcodeblock %}
<p>With this raw data you can construct any number of touch schemes, such as knowing when to scroll and when to select something, as is the case with UITableView.</p>
<p>UIControl derivatives (such as UIButton) get a simpler abstraction:&nbsp; they use that data &amp; translate it to different events such as <codetouchdowninside>&lt; code&gt;and `touchUpInside`.&nbsp; These don&rsquo;t work for all views, so sometimes to detect a tap you have to roll your own.</codetouchdowninside></p>
<p>In general, you can just look at the touchesEnded event and check the tapCount property to see if the user tapped an element:</p>
{% codeblock %}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
UITouch *touch = [touches anyObject]; //assume just 1 touch
if(touch.tapCount == 1) {
//single tap occurred
}
}{% endcodeblock %}
<p>&nbsp;<a href="http://flux88.com/files/media/image/WindowsLiveWriter/DetectingataponaUITextView_8AB1/uitextview_4.png"><img src="/images/uitextview_thumb_1.png" height="283"   /></a></p>
<p>I wanted to use this on a view that contained a full-screen UITextView.&nbsp;</p>
<p>Unfortunately, as of the iPhone SDK 3.0, UITextView swallows this event completely.&nbsp; I imagine because of the new feature where you can select text to copy &amp; paste.&nbsp; You can get touchesBegan, touchesMoved, and touchesCancelled, but no touchesEnded.&nbsp; (In fact, the touch actually gets cancelled by the UITextView).&nbsp; Even by subclassing UITextView I could not get this event.</p>
<p>Luckily I found a work-around.&nbsp; It&rsquo;s not exactly pretty, but it works for me.</p>
<p>First I needed to subclass UIWindow so that I can get control at the very beginning of every touch.</p>
<p>Next I needed to change my MainViewController.xib, which creates the window, to point to my new class.</p>
<p>Then, in the sendEvent method, I need to check for 3 things:</p>
<ul>
<li>is this touch ending?</li>
<li>is this touch hitting my custom text view?</li>
<li>is this touch a single tap?</li>
</ul>
<p>Here' is the code for my custom window:</p>
{% codeblock %}
//CustomWindow.h
@interface CustomWindow : UIWindow {
}
@end
//CustomWindow.m
#import &quot;CustomTextView.h&quot;
@implementation CustomWindow
-(void)sendEvent:(UIEvent *)event {
//loop over touches for this event
for(UITouch *touch in [event allTouches]) {
BOOL touchEnded = (touch.phase == UITouchPhaseEnded);
BOOL isSingleTap = (touch.tapCount == 1);
BOOL isHittingCustomTextView =
(touch.view.class == [CustomTextView class]);
if(touchEnded &amp;&amp; isSingleTap &amp;&amp; isHittingCustomTextView) {
CustomTextView *tv = (CustomTextView*)touch.view;
[tv tapOccurred:touch withEvent:event];
}
}
<span class="Apple-style-span" style="font-family: Arial; white-space: normal; ">{% codeblock %}
[super sendEvent:event];{% endcodeblock %}
</span>}
@end{% endcodeblock %}
<p>If all the 3 BOOLs turn out to be true, then I simply call a method I defined on my CustomTextView.</p>
<p>This CustomTextView then calls a similar method on it&rsquo;s tapDelegate (which I created).&nbsp; My view controller then adheres to the TapDelegateProtocol (which contains this method) and can now detech taps over a UITextView!</p>
<p>Now my textview becomes fullscreen when you tap it, and another tap brings back the tab bar at the bottom and navigation bar at the top.</p>
<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:0767317B-992E-4b12-91E0-4F059A8CECA8:e51873d5-b699-4cc4-832d-e6102c491eba" class="wlWriterEditableSmartContent">Technorati Tags: <a rel="tag" href="http://technorati.com/tags/iPhone">iPhone</a>,<a rel="tag" href="http://technorati.com/tags/Cocoa">Cocoa</a>,<a rel="tag" href="http://technorati.com/tags/Objective-C">Objective-C</a></div>
