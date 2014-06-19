---
layout: post
title: "Ruby Style Iteration in Swift"
date: 2014-06-18 08:49:39 -0500
comments: true
categories: swift 
---

It's no secret I'm a fan of Ruby. Idiomatic Ruby iteration looks like this:

```ruby
5.times do |i|
  puts "Iteration ##{i+1}"
end
```

This outputs:

<pre class="shell">
Iteration #1
Iteration #2
Iteration #3
Iteration #4
Iteration #5
</pre>

You can also iterate over collections in this way:

```ruby
["apples", "bananas", "cherries"].each do |item|
  puts "Eating #{item}"
end
```

<!-- more -->

And of course the output is this:

<pre class="shell">
Eating apples
Eating bananas
Eating cherries
</pre>

In Swift, your main workhorse for iteration is the _for loop_. Using the same examples above, it would look like this in Swift:

```
for i in 0..5 {
  println("Iteration #\(i)")
}
```

And the collection version...

```
for item in ["apples", "bananas", "cherries"] {
  println("Eating \(item)")
}
```

This is pretty clean syntax and there's nothing wrong with it.  But in my quest to explore the Swift language I thought it would be interesting to implement Ruby's style of _collection-first_ iteration.  As it turns out, it's simple.

Let's start with the `.times` implementation.  For this we have to extend the `Int` struct. We'll start with the simpler example of not yielding the argument `i` to the block each time (we'll add it later).

```
extension Int {
  func times(block: ()->()) {
    for _ in 0..self {
      block()
    }
  }
}
```

With that in place, we can do this:

```
3.times { print("Ho, ") }
```

That's pretty clean!  Let's implement the variant that yields `i` each time through the block. For this we have to define another function with the same name (but different signature):

```
extension Int {
   func times...

   func times(block: (Int) -> ()) -> Int {
     for i in 0..self {
       block(i)
     }
     return self
   }
}
```

Note that this version also returns `self`, so you can assign the result of the iteration to a variable, if you wanted.

Usage here is slightly different:

```
5.times { i in println("Iteration \(i)") }
```

Still pretty nice, and for simple loops, I give this a :thumbsup:.

### What about collections?

Using the same technique, we should be able to provide similar functionality to Arrays:

```
extension Array {
	func each(block: T -> ()) -> Array<T> {
	  for item in self {
	    block(item)
	  }
	  return self
	}
}
```

_Note that the `T` type parameter comes from the initial `Array` definition._

With that we can iterate over items like this:

```
["Lannister", "Stark", "Greyjoy", "Tyrell", "Baratheon"].each { house in 
  println("House \(house)")
}
```
Pretty simple. But `Array` is not the only thing we can enumerate. What about other types that you can use in a `for` loop, such as... `Dictionary`?

Dictionaries have keys and values, so we'll iterate over the pair...

```
extension Dictionary {
    func eachPair(block: (KeyType, ValueType) -> ()) -> Dictionary<KeyType, ValueType> {
        for (key, val) in self {
            block(key, val)
        }
        return self
    }
}
```

Note here that `KeyType` and `ValueType` come from the initial declaration of `Dictionary`. This is important because `KeyType` actually has a constraint on it that enforces that it complies to the `Hashable` protocol.

With this you can iterate over dictionaries like this:

```
let mealPlan = [ "breakfast": "pancakes", "lunch": "burrito", "dinner": "steak"]

mealPlan.eachPair {
    meal, item in println("Having \(val) for \(key)")
}

```
### Should you use this?

This is all well and good, but should you use it? This post is more of an exercise of _what can we accomplish_ with Swift. Especially in the case of the dictionary, I actually prefer the for loop syntax:

```
for (meal, item) in mealPlan {
  ...
}
```

So I think these are best left as an exercise in *practice*, not necessarily a recommendation to make Swift behave just like Ruby. If you want that, [RubyMotion](http://rubymotion.com) is a fine choice.
