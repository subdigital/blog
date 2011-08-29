--- 
layout: post
title: Handy Categories on NSString
date: 2010-4-20
comments: true
link: false
---
In Objective-C there is a great feature called _Categories_. To .NET folk, this closely resembles extension methods, and it is a great way to achieve utility code re-use and in general heighten the level of the code that you're working with. It's also a great way to turn a very hairy method and section it off into very simple, coherent tasks.

In some cases this means adding methods that don't necessarily belong on the class in question, but they make perfect sense in the context of your application.

In other cases, you can use Categories to add methods that ought to be there in the first place.

Here are a few handy categories on NSString that I carry around from project to project:

{% codeblock NSString+Common.h lang:objc %}
@interface NSString (Common)

-(BOOL)isBlank;
-(BOOL)contains:(NSString *)string;
-(NSArray *)splitOnChar:(char)ch;
-(NSString *)substringFrom:(NSInteger)from to:(NSInteger)to;
-(NSString *)stringByStrippingWhitespace;

@end
{% endcodeblock %}

{% codeblock NSString+Common.m lang:objc %}
#import "NSString+Common.h";
@implementation NSString (Common)
-(BOOL)isBlank {
  if([[self stringByStrippingWhitespace] isEqualToString:@""])
    return YES;
  return NO;
}

-(BOOL)contains:(NSString *)string {
        NSRange range = [self rangeOfString:string];
       return (range.location != NSNotFound);
}

-(NSString *)stringByStrippingWhitespace {
      return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

-(NSArray *)splitOnChar:(char)ch {
    NSMutableArray *results = [[NSMutableArray alloc] init];
   int start = 0;
     for(int i=0; i&lt;[self length]; i++) {
            
           BOOL isAtSplitChar = [self characterAtIndex:i] == ch;
              BOOL isAtEnd = i == [self length] - 1;
                             
           if(isAtSplitChar || isAtEnd) {
                     //take the substring &amp; add it to the array
                 NSRange range;
                     range.location = start;
                    range.length = i - start + 1;
                      
                   if(isAtSplitChar)
                          range.length -= 1;
                 
                   [results addObject:[self substringWithRange:range]];
                       start = i + 1;
             }
          
           //handle the case where the last character was the split char.  we need an empty trailing element in the array.
            if(isAtEnd &amp;&amp; isAtSplitChar)
                       [results addObject:@""];
   }

   return [results autorelease];
}

-(NSString *)substringFrom:(NSInteger)from to:(NSInteger)to {
  NSString *rightPart = [self substringFromIndex:from];
  return [rightPart substringToIndex:to-from];
}

@end
{% endcodeblock %}


To use these new functions, you simply reference the header file and access them as if they were built-in methods on NSString:

{% codeblock lang:objc %}
[@"foo.xml" splitOnChar:'.']; // returns NSArray with 2 elements: ["foo", "xml"]
{% endcodeblock %}

{% codeblock lang:objc %}
[@"" isBlank]; // returns YES
{% endcodeblock %}

I'm used to having access to higher level methods like these in C# and Ruby, however in Objective-C they seem to be oddly missing. Thankfully Categories can fill this gap for now.
