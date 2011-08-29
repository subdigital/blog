--- 
layout: post
title: Handy Categories on NSString
date: 2010-4-20
comments: true
link: false
---
<p>In Objective-C there is a great feature called Categories. To .NET folk, this closely resembles extension methods, and it is a great way to achieve utility code re-use and in general heighten the level of the code that you're working with. It's also a great way to turn a very hairy method and section it off into very simple, coherent tasks.</p>
<p>In some cases this means adding methods that don't necessarily belong on the class in question, but they make perfect sense in the context of your application.</p>
<p>In other cases, you can use Categories to add methods that ought to be there in the first place.</p>
<p>Here are a few handy categories on NSString that I carry around from project to project:</p>`<strong>NSString+Common.h</strong>`
{% codeblock %}
#import <br />@interface NSString (Common)<br />-(BOOL)isBlank;<br />-(BOOL)contains:(NSString *)string;<br />-(NSArray *)splitOnChar:(char)ch;<br />-(NSString *)substringFrom:(NSInteger)from to:(NSInteger)to;<br />-(NSString *)stringByStrippingWhitespace;<br />@end
{% endcodeblock %}`<strong>NSString+Common.m</strong>`
{% codeblock %}
#import "NSString+Common.h";<br />@implementation NSString (Common)<br />-(BOOL)isBlank {<br />      if([[self stringByStrippingWhitespace] isEqualToString:@""])<br />               return YES;<br />        return NO;<br />}<br />-(BOOL)contains:(NSString *)string {<br />        NSRange range = [self rangeOfString:string];<br />       return (range.location != NSNotFound);<br />}<br />-(NSString *)stringByStrippingWhitespace {<br />      return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];<br />}<br />-(NSArray *)splitOnChar:(char)ch {<br />    NSMutableArray *results = [[NSMutableArray alloc] init];<br />   int start = 0;<br />     for(int i=0; i&lt;[self length]; i++) {<br />            <br />           BOOL isAtSplitChar = [self characterAtIndex:i] == ch;<br />              BOOL isAtEnd = i == [self length] - 1;<br />                             <br />           if(isAtSplitChar || isAtEnd) {<br />                     //take the substring &amp; add it to the array<br />                 NSRange range;<br />                     range.location = start;<br />                    range.length = i - start + 1;<br />                      <br />                   if(isAtSplitChar)<br />                          range.length -= 1;<br />                 <br />                   [results addObject:[self substringWithRange:range]];<br />                       start = i + 1;<br />             }<br />          <br />           //handle the case where the last character was the split char.  we need an empty trailing element in the array.<br />            if(isAtEnd &amp;&amp; isAtSplitChar)<br />                       [results addObject:@""];<br />   }<br />  <br />   return [results autorelease];<br />}<br />        <br />-(NSString *)substringFrom:(NSInteger)from to:(NSInteger)to {<br /> NSString *rightPart = [self substringFromIndex:from];<br />      return [rightPart substringToIndex:to-from];<br />}      @end
{% endcodeblock %}
<p>To use these new functions, you simply reference the header file and access them as if they were built-in methods on NSString:</p>
{% codeblock %}
[@"foo.xml" splitOnChar:'.']; // returns NSArray with 2 elements: ["foo", "xml"]
{% endcodeblock %}
{% codeblock %}
[@"" isBlank]; // returns YES
{% endcodeblock %}
<p>I'm used to having access to higher level methods like these in C# and Ruby, however in Objective-C they seem to be oddly missing. Thankfully Categories can fill this gap for now.</p>
