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
{% codeblock lang:objc %}
@implementation SplashScreenController
-(void)viewDidLoad {
  UIProgressView *progressView = [[[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar] autorelease];
  int width = 200;
  progressView.frame = CGRectMake((320-width)/2, (480-10)/2 + 20, width, 10);
  [self.view addSubview:progressView];
 
  UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake((320-width)/2, (480-10)/2, width, 20)] autorelease];
  label.font = [UIFont fontWithName:@"Courier" size:12];
  label.backgroundColor = [UIColor clearColor];
  label.textColor = [UIColor darkGrayColor];
  label.textAlignment = UITextAlignmentCenter;
  label.text = @"Preparing the awesome ...";
  [self.view addSubview:label];
 
  proxy = [[TekpubProxy alloc] init];
  proxy.delegate = self;
  proxy.progressDelegate = progressView;
  [proxy asyncUpdateProductions];
}

- (void)doneUpdatingProductions {
  proxy.delegate = nil;
  proxy.progressDelegate = nil;
  [proxy release];
  tekpubAppDelegate *appDelegate = (tekpubAppDelegate *)[[UIApplication sharedApplication] delegate];
  [appDelegate doneLoading];
}

- (void)failedUpatingProductions {
  UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Error connecting!"
    message:@"We couldn't fetch the `awesome` from tekpub.com.  Are you connected to the internet?"
    delegate:nil 
    cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
  [alert show];
}
@end

{% endcodeblock %}
<p>The first few lines of code simply set up some UI elements that weren't part of the NIB file.  Doing it this way is certainly a matter of preference, and I find that occasionally building UI controls is easier than in Interface Builder.</p>
<p>Next up, we kick off the async process via a separate class called TekpubProxy.  This class utilizes the excellent <a href="http://allseeing-i.com/ASIHTTPRequest/">ASIHTTPRequest</a> library to do easy asynchronous network requests, complete with progress callbacks.  A bonus is that the progressDelegate automatically detects when you set it to a UIProgressView and automatically updates the status.  <em>How cool is that?! </em></p>
<p>Finally, when the splash screen is notified that the loading has completed, we call a method on the App Delegate in order to proceed with the rest of the application.</p>
<p>Here is the AppDelegate class:</p>
{% codeblock lang:objc%}
@implementation tekpubAppDelegate

@synthesize window;
@synthesize splashScreenController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
  // Add the tab bar controller's current view as a subview of the window
  [window addSubview:splashScreenController.view];
}

-(void)doneLoading {
  ProductionsController *controller = [[ProductionsController alloc] initWithStyle:UITableViewStylePlain];
  navController = [[UINavigationController alloc] initWithRootViewController:controller];
  navController.navigationBar.tintColor = [UIColor blackColor];
  [window insertSubview:navController.view belowSubview:splashScreenController.view];

  [UIView beginAnimations:@"fadeIn" context:nil];
  [UIView setAnimationDuration:1.5];
  splashScreenController.view.alpha = 0;
  [UIView commitAnimations];

  [controller release];
}

@end
{% endcodeblock %}

We utilize a nice cross-fade animation to bring the navigation controller stack into view. The end result is quite nice, and makes the 2-3 second loading time much more bearable.

<img src="https://flux88.s3.amazonaws.com/images/tekpub-splash.png" alt="tekpub-splash-screen" />
