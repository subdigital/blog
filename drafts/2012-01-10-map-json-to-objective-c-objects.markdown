---
layout: post
title: "Map JSON to Objective-C Objects"
date: 2012-01-10 21:07
comments: true
categories: iOS
---

I was sitting at NSCoder Night and someone was asking about how to map JSON & XML responses into Objective-C APIs.  
I showed how I handled it in [DeliRadio](http://m.deliradio.com) and it picqued some interest.

## First, Doing it Manually

If you were to take a JSON document and parse it manually, you might do something like this:

Given a JSON response of:

```
    {
      name:  "My Station",
      tracks: [
        {
          id: 25,
          title: "Your Whole Heart",
          artist_name: "Jackie Tanner",
        },
        {
          id: 175,
          title: "Raccoon Days",
          artist_name: "Bucket Glory"
        }
      ]
    }
```

We can easily translate this into an `NSDictionary` a library like [JSONKit](https://github.com/johnezang/JSONKit) or similar.  Once
we have that, it's pretty trivial to pass the dictionary on to a model object so it can hydrate itself.

```
      NSDictionary *jsonData = [jsonString objectFromJSONString];
      Playlist *playlist = [[Playlist alloc] initWithDictionary:jsonData];
```

```
  @interface Playlist

  @property (nonatomic, copy) NSString *name;
  @property (nonatomic, retain) NSArray *tracks;

  - (id)initWithDictionary:(NSDictionary *)dictionary;

  @end

  @implementation Playlist

  - (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
      self.name = [dictionary objectForKey:@"name"];
      self.tracks = [NSMutableArray array];
      for (id trackData in [dictionary objectForKey:@"tracks"]) {
        Track *track = [[[Track alloc] initWithDictionary:trackData] autorelease];
        [self.tracks addObject:track];
      }
    }
    return self;
  }

  @end
```

You can assume here that `Track` has a similar initializer that knows how to parse the values at that level.

At this point, we are parsing the JSON response and building up Objective-C objects based on it, but it is definitely a manual operation.
Any time you have a change in the response, you'll need to update the class to contain the new data format _and_ update the mapping code to reflect it.

If you've ever used something like [Jimmy Bogard](http://lostechies.com/jimmybogard/)'s [Automapper](https://github.com/AutoMapper/AutoMapper), you're probably hoping for something a bit easier.  Using Objective-C's runtime,
we can achieve a very primitive mapping solution that might just work for simple scenarios.  Automapper is geared towards object-object mappings and flattening, 
but the concept of mapping between two things with minimal fuss is what we're after.

## First, Some Assumptions and Constraints

There are numerous ways to achieve this, but in my case I chose to use a base class.  In a future refactoring, I hope to extract this out to a standalone object
and leave your model hierarchy alone.

Writing a mapper means dealing with all kinds of crazy input that you might not expect.  How do you handle `null` values?  What do you do if your type is an
`NSNumber` but the JSON property is a string?  How do you deal with date formatting?

I'm going to skip all of that and focus on the core concept.  We'll deal with simple values for now:

* NSString
* NSNumber
* nested objects

## "Automatic" versus "Defined" Mappings

In order to figure out what properties to map values to, we need a mapping that tells us this information.  

An *automatic* mapper would figure out that a key of `"name"` in the JSON structure maps to a similarly named property `name` on the Objective-C object.
But what about cases like `"artist_name"`?  We certainly don't want to abandon our naming conventions in Objective-C and call our property
`artist_name`.  A smart mapper would be able to infer a few variations of naming style and pick an appropriate match.  Of course, any exceptions could be provided
manually so that you get the benefit of automatic mapping when it works, and you can give it a hint when it does not.

A *manual* mapper means you have to provide the mapping details yourself, for each and every property you wish to map.  This is generally less code than the
manual parsing approach shown above, especially when nested objects are concerned.

We'll focus on writing a manual mapper first, though an automatic mapper would be the logical next step.



