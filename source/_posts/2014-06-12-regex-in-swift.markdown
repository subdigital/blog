---
layout: post
title: Regex in Swift
date: 2014-06-12 20:56
comments: true
categories: swift
---

I've been playing around with Swift and one thing that struck me as odd/disappointing is the lack of regular expression literals.

First off, the language is new and yes I've filed [a radar](http://openradar.appspot.com/17257306) (rdar://17257306 for Apple folks). Please dupe it if you care about this.

What I mean by regular expression literals is this (Ruby code):

```ruby
if name =~ /ski$/
  puts "#{name} is probably polish"
end
```

<!-- more -->

The idea is that if you just want a quick match, you can use the `=~` operator to just return the regex match given the following pattern. 
The other aspect that is friendly is the `/pattern/` syntax
which makes it very easy to type a regular expression without ceremony.  You don't have to escape anything except a literal forward slash, like this:

```ruby
url_pattern = /^https?:\/\/.*/
```

This is much better than having to double escape backslashes (which are very common in regular expressions). When you have to create regular expressions using strings it gets ugly quickly. Here's an
example with Objective-C:

```objc
NSRegularExpression *regex = [NSRegularExpression 
  regularExpressionWithPattern:@"\\s+\\w{4,10}\\s\\d+"
                       options:0
                         error:nil];
```

Having to escape every backslash just hurts readability and I think that's reason enough to justify a literal syntax.  The other unfortunate part is the unnecesary class creation. Surely when
you need more power it will be necessary to have a full class in place to support advanced needs.  But for common tasks (which are incredibly common in scripting languages) it seems
overkill.

## What about Swift?

Swift currently has no classes or syntax for regular expressions, which leaves you to use `NSRegularExpression` like I show above.

However, we can get close to what I describe above, using Swift's powerful operator support.  Consider a simple regular expression class like this:

```
class Regex {
  let internalExpression: NSRegularExpression
  let pattern: String

  init(_ pattern: String) {
    self.pattern = pattern
    var error: NSError?
    self.internalExpression = NSRegularExpression(pattern: pattern, options: .CaseInsensitive, error: &error)
  }

  func test(input: String) -> Bool {
    let matches = self.internalExpression.matchesInString(input, options: nil, range:NSMakeRange(0, countElements(input)))
    return matches.count > 0
  }
}
```

This is a dead simple wrapper around `NSRegularExpression` that makes a ton of assumptions, yes. Usage is way cleaner:

```
if Regex("\\w{4}").test("ABCD") {
  println("matches pattern")
}
```

We still have the unfortunate string representation of a pattern, but it's cleaner than using `NSRegularExpression` natively.

## Now Comes the =~ Operator

Given some prodding from [Step Christopher](https://twitter.com/RandomStep/status/476784959232163840) I decided to try to implement the operator myself. As it turns out, this is pretty simple:

```
operator infix =~ {}
```

That just declares the operator's *position*, as in it's a operator *between* two elements instead of before or after (like `++` might be). Next we declare a function using this operator:

```
func =~ (input: String, pattern: String) -> Bool {
  return Regex(pattern).test(input)
}
```

The hard work was already done for us, all we had to do is wrap the elements and call the function we desired.

In the end, this results in a pretty damn readable regex test:

```
let phoneNumber = "(800) 555-1111"
if phoneNumber =~ "(?\\d{3})?\\s\\d{3}-\\d{4}" {
  println("That looks like a valid US phone number")
}
```

I think this is pretty awesome, and once Apple reads my radar and implements `/regex/` literal syntax, I'll be a happy camper.

### Update

A helpful [commenter on Hacker News](https://news.ycombinator.com/item?id=7890148) pointed me in a direction that is closer 
to what I want, but using existing API:

```
if let match = name.rangeOfString("ski$", options: .RegularExpressionSearch) {
  println("\(name) is probably polish")
}
```

Indeed I was not aware of this, and looks quite helpful.
