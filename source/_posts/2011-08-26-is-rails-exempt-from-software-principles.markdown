---
layout: post
title: "Is Rails Exempt?"
date: 2011-08-26 07:58
comments: true
categories: ruby, rails
---

If you've been following the Ruby community recently, you'd notice that
there's are people calling our Rails (and Rails developers) for treating
Rails as if it is somehow _exempt_ from long-standing software
principles.

[Roy Osherove](http://osherove.com/), a fairly well-known .NET developer and author of The [Art of Unit Testing](http://artofunittesting.com/), ventured into Ruby-land
recently and commented on twitter about how Rails's
definition of unit & integration is quite different from his.

{% img tweet /images/rails-unit-integration-tweet.png %}

I have to agree with Roy. Those in the TDD camp in .NET understood the
difference and were (from my experience) fairly cognizent of isolating
concerns and not mixing the 2 concepts. Some even go as far as to
isolate integration tests into their own assembly, providing a physical
separation further guaranteeing that a unit test project won't touch
web services or the database.

It's easy to assume from the outside that the Rails is just testing
nirvana and that _everyone_ does it and it's so easy.  Unfortunately it's
just not the truth.  Rails (and Ruby) make testing really easy but that
means it's even easier to do the wrong thing as well.

## Legacy Rails Apps

Now that Rails is (gasp) over 7 years old you're starting to see some
real legacy Rails applications out in the wild.

[Avdi Grimm](http://twitter.com/avdi) has a [good post](http://avdi.org/devblog/2011/08/22/your-code-is-my-hell/) on the topic of how many of the Rails apps he comes to work on are in poor shape, technically.

> Here are a few examples, just to give you an idea of what I’m talking about:
> 
> “Design Patterns are a Java thing. In Ruby you just write code.”
> 
> “The warnings Ruby produces are dumb; just disable them.”
> 
> “Sure they aren’t technically Unit Tests, but isolating objects turned out to be kind of hard and besides nobody else is doing it.”
> 
> “Stuff like the Law of Demeter isn’t really as important in Ruby code”
> 
> “That’s only a problem in large projects” (implying that this project will never become large).
> 

I've certainly been guilty of some of this. Rails makes it easy to do
things that can turn out to be problematic. As with anything, you have
to be disciplined to notice the warning signs and act accordingly.

When testing is painful, you're likely making mistakes. Some common
pain-points that I've experienced are:

* No tests - the app is hard to test because the design is poor. Classes
  are too tightly coupled and don't have clear delineation of
responsibilities.
* Tests break for unrelated reasons - the tests are covering too much
  behavior, so when a single behavior changes, many tests break.
* Tests break when implementation changes - the tests are probably
  utilizing too much mocking & stubbing. The tests are coupled heavily
to a particular implementation.
* Unclear what the problem is when a test breaks - Tests are probably
  too coarse-grained and may contain too many assertions per test.

These are just a sampling of what I've personally observed.

So why do many Rails developers ignore these concepts?

## Pragmatism at work

Many rails tutorials (and the default Rails template) treats model tests
as _unit_ tests. Since Rails models are by default based on Active
Record, they have data access baked into their core.  Doing proper unit
testing means you're testing a logical unit.  If your test involves a
model operation that requires a database round-trip, that's technically
an _integration_ test.  But does it really matter?

Most Rails developers will tell you no. Consider this spec:

```ruby
    describe Post do
      it "should be initially unpublished" do
        Post.new.published.should == false
      end
    end
```

This is a unit test. It tests a single piece of functionality and will
fail for just one reason.

Now, here's another example:

```ruby
    it "should fetch published articles" do
      # ?
    end
```

```ruby
    # post.rb
    class Post < ActiveRecord::Base
      def self.published
        where("published_at <= ?", Time.now)
      end
    end
```

How should you implement this spec? 

If you were trying to avoid hitting the database you might intercept the
`where` call and assert the parameters passed to it. But surely this
isn't the only way you could implement this method giving the same
behavior.  You might use `scopes` or another `where` call might actually
be added later that doesn't affect the outcome of this method in any way
that this test is concerned about.

```ruby
    it "should fetch published articles" do
      3.times { Factory.create :article }
      future_post = Factory.create :article, :published_at => 2.days.from_now
      posts = Post.published
      posts.size.should == 3
      post.should_not include future_post
    end
```

This test hits the database (numerous times, in fact) but it's testing
_exactly_ the behavior we need.  We aren't testing implementation, we're
testing that the behavior works as intended.  If we somehow muck with
the query, breaking it, this test will fail.  If we change the
implementation to use some other query means (scopes or whatever) this
test will still pass.

Is it so bad that the test hits the database?

There are drawbacks of course:

* The test requires a database, thus you have to migrate
* The `database_cleaner` gem will have to be present to clean out the
  database before each run
* These database statements make the test suite a LOT slower, so large
  test suites will eventually suffer.
* The tests could fail if the database isn't present (or migrated), or
  if the query is incorrect.  But this isn't likely to happen since
we're using a tested framework (ActiveRecord).

Ultimately this isn't really a unit test at all.  It's an integration
test.  So is `spec/models/post_spec.rb` the wrong place for this stuff?

The question eventually comes down to this: *What is more valuable?  A
fast, isolated test suite?  Or a test suite that breaks for the right
reasons?*

## Don't throw out good practices just because it's Ruby

I think it's important to be cognizant of software paradigms and use
them where they make sense. It's also important to recognize when
practices are being ignored because "celebrities" aren't touting them.

It is still valuable, however, to keep a fresh eye on old assumptions. Don't
always take things as gospel just because that's the way they have
always been. One
of the things I love about the Ruby community is how willing people are
to rock the boat & try something new.


