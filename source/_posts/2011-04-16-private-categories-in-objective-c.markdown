--- 
layout: post
title: Private Categories in Objective-C
date: 2011-4-16
comments: true
link: false
---
Sometimes properties can vastly simplify the memory management code when working with your private instance variables (or <em>ivars</em>). Here is an example:

<em>MyTableViewController.h</em>
{% codeblock lang:objc %}@interface MyTableViewController : UITableViewController {
    NSArray *items;
}

@property (nonatomic, retain) NSArray *items;

- (void)somethingChanged;

@end{% endcodeblock %}
<em>MyTableViewController.m</em>
{% codeblock lang:objc %}@implementation MyTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    //using the ivar
    items = [[NSArray arrayWithObjects:@"Item 1", @"Item 2", nil] retain];
    //using the property
    self.items = [NSArray arrayWithObjects:@"Item 1", @"Item 2", nil];}

- (void)somethingChanged {
    //using the ivar
    [items release];
    items = [[NSArray arrayWithObjects:@"New Item 1", @"New Item 2", nil] retain];
    //using the property
    self.items = [NSArray arrayWithObjects:@"New Item 1", @"New Item 2", nil];
    [self.tableView reloadData];
}

- (void)dealloc {
    [items release];
    [super dealloc];
}@end{% endcodeblock %}

Notice that in each use of the ivar, we have to take special care to manage the memory properly. In the first case, we have to make sure to retain the value, because `[NSArray arrayWithObjects:]` returns an autoreleased instance. In the second case, we have to make sure and release the first array before assigning it to the second array.

The only questionable part of using properties is probably obvious: <strong>You have exposed your internal state to outside classes, but only for the benefit of your implentation.</strong> It seems odd to change your public API simply to make the implementation a bit cleaner. How can we fix this?
<h2>Categories</h2>
Before we solve the above problem, let's take a slight detour and learn about categories. A category in Objective-C is similar to an extension method in .NET. You basically re-open the class, define a method (or many) and provide your implementation. The result is it appears as if those methods were part of the original class all along.

Here's an example of putting a startsWith method on the string class:

<em>NSString+FLUXAdditions.h</em>
{% codeblock lang:objc %}@interface NSString (FLUXAdditions)
- (BOOL)startsWith:(NSString *)prefix;
@end{% endcodeblock %}
<em>NSString+FLUXAdditions.m</em>
{% codeblock lang:objc %}@implementation NSString (FLUXAdditions)
- (BOOL)startsWith:(NSString *)prefix {
return [[self substringToIndex:[prefix length]-1] isEqualTo:prefix];
}
@end{% endcodeblock %}
[box type="info"]Notice the naming of the filename &amp; the category name. Most people use the + syntax to denote a category on the class they're adding on to. The prefix is also important. If you just name your category "Additions" then it's possible that other libraries you include (or future versions of the SDK) could have the same name, leading to a collision. The common practice is to utilize a company prefix on classes that could be reused by others or that could cause collisions in the future.[/box]
Now that I have that implemented, all I have to do is include my header file anywhere I want to use this method. You can even do this in a global header file.
{% codeblock lang:objc %}#import "NSString+FLUXAdditions.h"{% endcodeblock %}
{% codeblock lang:objc %}[@"My awesome string" startsWith:@"My"];  //returns YES
[@"My awesome string" startsWith:@"Foo"]; //returns NO;{% endcodeblock %}
So now that we understand how categories work, how can we utilize this to solve our original problem?
<h2>Private Categories</h2>
We can utilize private categories to give us the benefit of properties for our ivars, but at the same time, NOT expose those to the outside world. Here's how it works (using our example from above):

<em>MyTableViewController.m</em>
{% codeblock lang:objc %}@interface MyTableViewController ()
@property (nonatomic, retain) NSArray *items;
@end@implementation MyTableViewController@synthesize items;...@end{% endcodeblock %}
Notice how we declared the category interface directly the implementation file. This works because the .m file will only be loaded once, and since it's inside the .m file, no other classes will ever know it existed. We can remove the property declaration from the header file and everything should work the same.

Private categories can also be used to provide method declarations, which can help you order your methods in a way that makes sense, and not worry about the compiler complaining about methods that haven't been declared yet.
<h2>Private Category Gotcha</h2>
One thing that tripped me up is the name of the private category. When first doing this I originally chose the name "Private". But there's something peculiar about named category methods versus unnamed ones (like I have above).

Unfortunately Xcode4 wasn't very smart about telling me what was wrong, instead giving me conflicting error messages:

<a href="http://flux88.com/wp-content/uploads/2011/04/xcode4-private-category-error.png"><img src="/images/xcode4-private-category-error-tm_.jpg"  height="124"  /></a>

This <a href="http://stackoverflow.com/questions/1052233/iphone-obj-c-anonymous-category-or-private-category/1055213#1055213" target="_blank">stack overflow answer</a> helped explain the difference between the two styles.

Hopefully this helped you understand how to leverage categories to clean up your public APIs!
