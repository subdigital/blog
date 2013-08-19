---
layout: post
title: "75 Essential Tools for iOS Developers"
permalink: /2013/08/the-ios-developers-toolbelt
date: 2013-08-15 13:56
comments: true
categories: iOS

---


If you were to go to a master woodworker's shop, you'd invariably find a plethora of tools that he or she uses to accomplish various tasks.

In software it is the same. You can measure a software developer by how they use their tools.  Experienced software developers _master_ their tools. It is important to learn your current tools deeply, and be aware of alternatives to fill in gaps where your current ones fall short.

With that in mind, I present to you a _gigantic_ list of tools.  Some of these I use daily, others I see potential in.  If you have more tools you'd like to see here, just make sure to add a comment.

<!--more-->

I tried to categorize these the best I can.  Some of the entries are websites, some are back-end services, but most are apps that you install.  Not all of the apps are free, so I'll make a note with a _$_ to denote that an app costs money.

And without further ado, we'll start from the beginning of any project, and that 

## Inspiration

- [pttrns](http://pttrns.com) - A great library of iOS screen designs categories 
by task. If you want to see how other apps handle activity feeds, for instance, 
this is a great place to go see a bunch of examples.
- [TappGala](http://tappgala.com) - Another great collection of nice app designs.  It's 
not categorized by task, but is just a list of great apps to get inspiration from.
- [Cocoa Controls](http://cocoacontrols.com) - A great list of components (code) that you
can use in your iOS apps.  Sometimes you'll find great pieces of code that 
can save you time, other times you can just learn how other developers accomplish certain
features.  Subscribe to their weekly newsletter; all signal, little noise.
- [IICNS](http://www.iicns.com) - A collection of really great icons.  Get inspired, but don't
copy.
- [Dribbble](http://www.dribbble.com/search?q=ios) - Some of the best digital designers post up
their work for all to see. A treasure-trove of designs to look at.
- [Capptivate](http://capptivate.co/) - a gallery of inspirational designs.  Some contain animations.  *Thanks, [@joaopmaia](http://twitter.com/joaopmaia)*!

## Design

- [Mocks](http://celestialteapot.com/mocks) ($) - An easy to use tool to create a quick
mockup of an iOS app.  Comes with a bunch of the default controls you can use to assemble
something quickly.
- [Briefs](http://giveabrief.com) ($) - A really useful app that allows you to create a mockup of an app and stitch them together so you can see the interaction.  Deploy to a device so you can see what it feels like in your hand.
- [Acorn](http://www.flyingmeat.com/acorn/) ($) - A strong competitor to Photoshop, only way cheaper.  I find myself reaching for Photoshop less & less these days.  Under active development.
- [Sketch](http://www.bohemiancoding.com/sketch/) ($) - A vector-based drawing tool that is increasingly useful these days, as screen sizes and pixel densities change.  It is often helpful to design once and have the freedom to scale up & down as needed.  Also sports a really powerful export system.  For some example Sketch projects, check out [Sketchmine](http://sketchmine.co).  See my [screencast on Sketch](http://nsscreencast.com/episodes/079-sketch) for a live demo.
- [iOS 7 PSD by Teehan+Lax](http://www.teehanlax.com/tools/ios7/) - A super handy resource if you (or your designer) uses Photoshop.  An [iOS 6 version](http://www.teehanlax.com/blog/ios-6-gui-psd-iphone-5/) is also available.
- [Bjango's Photoshop Actions](http://bjango.com/articles/actions/) - A definite time-saver if you use Photoshop to design iOS apps.  One click access to resize canvases, scale by 200% (or 50%), set global lighting to 90º, and more.  Their [blog](http://bjango.com/articles/) also has a bunch of useful Photoshop workflow tips.
- [xScope](http://xscopeapp.com/) ($) - An indespensible swiss-army knife of tools such as guides, pixel loupes, screen rulers, and more.  Want to know what color value that pixel is?  Want to see how many pixels between a button and the window for a random Mac app?  xScope has you covered.  Also check out their [companion iPhone app](https://itunes.apple.com/app/xscope-mirror/id488819289?mt=8&ign-mpt=uo%3D4) for [mirroring designs](http://xscopeapp.com/guide#mirror) you're working on and seeing them in pixel-perfect glory on your iDevice.
- [Glyphish](http://glyphish.com) ($) - A fantastic collection of high quality icons for your iOS apps. Apple doesn't provide a lot of built-in icons, so it's handy to have a collection of icons covering all kinds of various concepts.  _I'm still looking for a use for that baby icon though_.  Glyphish comes in packs, and the latest pack has iOS 7 "thin line" icons which will be very handy when designing an iOS 7 app.
- [Fontastic Icons for iOS](https://github.com/AlexDenisov/FontasticIcons) - An open source set of classes for utilizing icon fonts, such as [Font Awesome](http://fortawesome.github.io/Font-Awesome/) in your iOS app.  Quickly and easily have an icon in whatever pixel dimensions you require.  Since fonts by nature can be scaled up and down with ease, this makes a really nice way to ship & use your icons without having to export multiple versions for the sizes you require.
- [PaintCode](http://paintcodeapp.com) ($) - A vector-based drawing tool that exports your artwork as the equivalent Core Graphics source code.  Awesome for learning how Core Graphics drawing works, but also incredibly handy if you want your drawing to be dynamic.  See my [screencast on PaintCode](http://nsscreencast.com/episodes/80-paintcode) for a live demo.
- [Edge Insets](https://itunes.apple.com/us/app/edge-insets/id622650418?mt=12) ($) - A simple tool that helps you define your edge insets for repeatable images.  Available on the Mac App Store.
- [LiveView](http://www.zambetti.com/projects/liveview/) - A remote screen viewer for iOS, making it easy to immediately see your designs on a device.  *Thanks, [@_funkyboy](http://twitter.com/_funkyboy)*!
- [Skala Preview](http://bjango.com/mac/skalapreview/) ($) - Another excellent tool for quickly showing your designs off on a real device.  The guys at Bjango are awesome and this app is deserving of the price.  *Thanks, jn40*!

## Source Control

- [Git](http://gitscm.org/) - If you're not using source control stop what you're doing and rectify that.  I use git for everything I do and love it.
- [Kaleidoscope](http://www.kaleidoscopeapp.com/) ($) - The best diff/merge tool around.  Does 3-way merges and is beautiful to look at.  I use it every day.
- [p4merge](http://www.perforce.com/product/components/perforce-visual-merge-and-diff-tools) - A free, ugly alternative to Kaleidoscope.  Powerful 3-way merge, but good luck finding the download link. It's hidden deeper in their site every time I look for it.
- [Git X](http://gitx.frim.nl/) - A simple, powerful GUI tool for visualizing git timelines and quickly & easily staging commits.  I usually live in the Terminal for git usage, but fall back to this app when I need to stage hunks of changes into logical commits.  This is a fork of the original (abandoned) GitX, which I found on this [list of forks](http://gitx.org).
- [Source Tree](http://www.sourcetreeapp.com/) - A free, full-featured Git application.  I don't use this because I favor the command line, but if a GUI tool is your cup-o-tea, check this app out.

## Dissecting Apps

- [pngcrush](http://pmt.sourceforge.net/pngcrush/) - This little utility can _crush_ & _uncrush_ PNG files, which is handy when you want to view images contained in app bundled distributed in the App Store.  Just open iTunes, view the local Apps list, and right click on any icon to Show in Finder.  Once there, open up the app and you'll see a bunch of PNG files, but you can't view them.  Using pngcrush you can extract the full version so it can be opened with Preview.
- [appcrush.rb](https://github.com/boctor/idev-recipes/tree/master/Utilities/appcrush) - This handy little ruby script will automate the above process for all images.  Just point it to a `.app` file on your disk and it will extract all the images to a folder on your desktop.  Handy for seeing how apps on your phone accomplish certain designs.  Check out [my screencast on dissecting apps](http://nsscreencast.com/episodes/20-dissecting-apps) for a live demo.
- [Charles](http://charlesproxy.com) ($, free limited demo) - I don't know what's going on with the ugly UI or icon, but Charles is an _essential_ tool for any developer.  Charles acts as a proxy to allow you to inspect your network traffic to & from the iPhone Simulator.  You can also inspect traffic from your device by setting your phone's proxy to your Mac running Charles.  With self-signed SSL certificates, request & response breakpoints, and request/response viewers, Charles is really amazingly powerful.  A must-have tool.  Again, my screencast on [dissecting apps](http://nsscreencast.com/episodes/20-dissecting-apps) covers this well.

## Editors

I know what you're thinking, don't all iOS developers use Xcode?  Well mostly, yes.  But with my love/hate relationship with Xcode, I believe there is tremendous value in considering alternatives.

- [AppCode](http://jetbrains.com/objc) - A full-fledged IDE from Jetbrains (makers of the excellent ReSharper for .NET).  Immensely powerful refactorings & features that help you write code faster.  Quickly identify dead code, automatically insert `#import` statements when you use related code, easily extract variables, methods, and classes.  My only wish for this app is that it would instead be a plugin to Xcode.
- [Vim](http://www.vim.org/) - Wait, vim?  Really?  Yes, there are folks who do all their Objective-C development in vim.  I'm not one of these, but I am a fan of vim for Ruby development.  As such, I'm a huge fan of...
- [Xvim](https://github.com/JugglerShu/XVim) - An Xcode plug-in that gives you vim keybindings.  Works well, 'nuff said.
- [OMColorSense](https://github.com/omz/ColorSense-for-Xcode) - Another plugin for Xcode, this one gives you a small display of color when your cursor is on a line looking like: `[UIColor redColor]`.  Clicking on this little color tab opens a color picker that you can change, and any change in color you make is reflected in the code by changing the line to `[UIColor colorWithRed:… green:… blue:… alpha:… ]`.  When someone is watching me write code with this enabled, they invariably ask me, *"Whoa!  What was that?!"*
- [KSImageNamed](https://github.com/ksuther/KSImageNamed-Xcode) - Another Xcode plug-in, this one allows you to autocompleted image filenames from your bundle when typing `[UIImage imageNamed:…]`.  Great way to avoid the inevitable typo that causes this method to return `nil` and you to subsequently waste 10 minutes trying to figure out why your images aren't displaying.
- [CocoaPods Xcode Plugin](https://github.com/kattrali/cocoapods-xcode-plugin) - This plug-in adds a menu item for interacting with CocoaPods.  Useful if you don't like dropping to the command line.
- [Alcatraz Package Manager](http://mneorr.github.io/Alcatraz/) - An awesome meta plug-in that allows you to easily install other Xcode color schemes and plug-ins with a single click.
- [Code Runner](https://itunes.apple.com/us/app/coderunner/id433335799?mt=12) ($) - a light-weight code-aware text editor that knows how to compile & run code in most languages.  Want to test out a quick snippet of Objective-C code and don't want to create an entire Xcode project to do it?  Code Runner to the rescue.

## Documentation

Ahhh, documentation, everyone's favorite topic.  Even still, documentation is really important to have, so pay attention so we can make your life easier.

- [appledoc](http://gentlebytes.com/appledoc/) - Want to automatically generate documentation that look's like Apple's?  Look no further.  Automatically inter-links symbols defined in your project as well as extracting discussion to output using specially formatted code-comments.  Generates official docsets and HTML web sites.
- [Dash](http://kapeli.com/dash/) ($) - A must-have API documentation viewer and code snippet manager.  This tool is really handy as it allows you to download & search API docs for all kinds of languages & frameworks with lightning speed.  The fastest way to get access to the docs.  I [integrate Dash with Alfred](http://joeworkman.net/blog/post-30037947509) to make searches even faster.

## Dependency Management

Yes, there's only one tool listed here.  I didn't want to include actual 3rd party libraries, as that would be a different list entirely.  When it comes to dependency management, there's only one game in town:

- [CocoaPods](http://cocoapods.org/) - The essential tool for Objective-C projects.  Allows you to quickly & easily integrate 3rd party libraries into your application.  It does so by creating a second static library project and automatically links this with your projects.  There are thousands of pods available, and it's easy to add support for libraries that you don't own (or perhaps are private).  I use CocoaPods in every single project I work on.

## Diagnostics & Debugging

At some point our app is in the field and we need to understand better what's going on, maybe to fix bugs or to improve performance.

- [Cocoa Lumberjack](https://github.com/robbiehanson/CocoaLumberjack) - a much more powerful `NSLog`, Cocoa Lumberjack offers advanced logging behaviors such as logging to rotated files, logging to the network, and filtering based on log level (info, debug, warn, error).  Covered by [NSScreencast Episode 61](http://nsscreencast.com/episodes/61-cocoa-lumberjack)
- [DCIntrospect](https://github.com/domesticcatsoftware/DCIntrospect) - crazy powerful tool that you'd link inside your app when running in debug and on the simulator.  Once you do, you can press the spacebar to get some really helpful view debugging support.  See exact dimensions of elements on the screen, print out view hierarchies, even nudge views horizontally or vertically.
- [Pony Debugger](https://github.com/square/PonyDebugger) - another tool you'd use by embedding a library in your debug builds, Pony Debugger actually utilizes Chrome's dev tools for seeing network requests coming out of the device, as well as a rudimentary Core Data browser.  It's hard to describe, but check out my [screencast on Pony Debugger](http://nsscreencast.com/episodes/54-pony-debugger) for more info.
- [Runscope](http://runscope.com/) ($) - Runscope is a service running online that can capture requests, log details, and give you valuable data about your API.  Simple to set up, as it's an HTTP pass-through API, all you need to change is your host name.
- [SimPholders](http://simpholders.com/) - Quick, easy access to your simulator folders.  Browse by iOS version, then app name and jump right to the folder in Finder.
- [Spark Inspector](http://sparkinspector.com/) - Debug your view hierarchy running on your app in debug mode, in 3D.  This app really has to be seen to fully understand the value, but it can really help to understand what views are used to compose your app.  Also contains a notification center inspector, so you can easily see what `NSNotification`s are firing and who is observing them.  Another app to look at that is similar is [Reveal](http://revealapp.com).

## Images

- [ImageAlpha](http://pngmini.com/) - A Mac app that allows you to convert a 24-bit PNG with transparency to an 8-bit PNG with an alpha channel.  Typically 8-bit PNGs don't have an alpha channel, so if your image can be represented in 8-bits (say, a solid color button) you can save a lot on storage by converting the 24-bit PNG to 8-bit using ImageAlpha.
- [ImageOptim](http://imageoptim.com/) - Another Mac app that compresses PNGs in order to save space.  Most PNG files can shave off a few % of the size, and sometimes you'll shrink the files by 30% or more.  Smaller images mean smaller app sizes and less memory used to load them at runtime.
- [Prepo](http://wearemothership.com/work/prepo) - A little Mac app that can quickly resize artwork in all the various sizes you might need.  Just drag a large icon file (say, 1024x1024) onto Prepo and watch it spit out 512x512 iTunesArtwork, 114x114 Icon@2x.png, and all the other sizes & filenames you'd expect.
- [Slender](http://dragonforged.com/slender/) ($) - an awesome app that analyzes your app and finds all sorts of problems, such as missing retina artwork, unused images, image that could benefit from compression and more.  Shave kilobytes off of your iPhone app by shedding unused images with Slender.

## Core Data

- [Mogenerator](http://rentzsch.github.com/mogenerator/) - still a super useful tool for generating smart subclasses of your `NSManagedObject`s in your Core Data model.  Some use Xcode for this, and resort to manually subclassing or creating categories in order to add logic to the models.  Mogenerator runs as a quick pre-compile script to generate subclasses for you to use.  It does this by creating an underscored version (`_User`) and a regular one for you to modify (`User`).
- [Base](http://menial.co.uk/software/base/) ($) - there will come a time when you need to inspect your actual Core Data sqlite database to see what's going on.  You can use the `sqlite3` command line tool, but Base offers a nice looking GUI browser.  Just don't vomit when you see the database schema that Core Data created for you.
- [Core Data Editor](http://christian-kienle.de/CoreDataEditor) ($) - for more advanced data anlysis, exploration, and modification you can use Core Data Editor.  This app understands Core Data, so you're working directly with the entities instead of database rows.

## Back-end Services

Ultimately your iOS app will likely want to talk to a server to share data, fetch new content, send push notifications or whatever.  While this can be accomplished manually, you might want a more drop-in solution.

- [Helios](http://helios.io) - Helios is an open-source framework that provides essential backend services for iOS apps, from data synchronization and push notifications to in-app purchases and passbook integration.  Built on top of many open source ruby gems, so you can pick & choose and build your own stack if you so desire.  Take a look at the [Nomad CLI](http://nomad-cli.com/) set of handy related tools as well.
- [Windows Azure Mobile Services](http://www.windowsazure.com/en-us/develop/mobile/) - you can think of this sort of like a programmable database in the cloud.  Create tables, run JavaScript on read, insert, delete to add additional functionality.  Really easy support for push notifications as well.
- [Urban Airship](http://urbanairship.com) - I've been using Urban Airship to deliver push notifications for a while now.  Really easy to integrate with, and small usage is free.
- [Parse](http://parse.com) - This is another data-in-the-cloud service, but offers an impressive API and online data browser.  We use Parse for a really small app and works well for that.

## Analytics

There are other players here, but none that I've seen have been compelling enough to switch from flurry.  I'm open to hearing suggestions, so let's hear about 'em in the comments.

- [Flurry](http://flurry.com) - I've used flurry for a long time to provide useful analytics on the usage of my apps.  Need to know when to stop supporting iOS 5?  Flurry gives you the numbers to have a realistic conversation.

## Deployment

- [Deploymate](http://www.deploymateapp.com/) ($) - Need to support iOS 4 still, but you're compiling with the iOS 6 SDK?  Deploymate will warn you when you're using symbols that don't exist in your deployment target.
- [Cupertino](https://github.com/nomad/cupertino) - Part of the Nomad CLI tools, Cupertino gives you command line access to managing devices & profiles in the Apple Provisioning Portal.  For example, just type `ios devices:list` to see the current list of devices in your account.  Useful for automating lots of processes.
- [Hockey App](http://hockeyapp.net/) ($) - A great service for managing the distribution of your ad-hoc builds.  Testers can get a link to install new betas over the air.  Also provides robust crash reporting so you can easily respond to crashes in your apps.
- [TestFlight](http://testflightapp.com) - A free service, similar to Hockey App.  We've used TestFlight with great success for easily distributing apps and collecting feedback from our users.  My only wish is that they'd start charging for the service.  Also includes analytics and crash reporting, but we don't use those features.
- [iOS Simulator Cropper](http://www.curioustimes.de/iphonesimulatorcropper/index.html) - A really easy way to snap images of the simulator, with or without status bar, with or without device chrome, etc.  Great for taking App Store or just general marketing screenshots.
- [Status Magic](http://shinydevelopment.com/status-magic/) ($) - Take better app store screenshots.  Nothing makes your app look less crappy than an App Store screenshot that includes a low battery, or low signal.  Status Magic gives you complete customization over what's present in your status bar, including removing elements, changing the time to "9:41 AM" like Apple tends to do, and more.
- [Crashlytics](http://crashlytics.com) - Excellent crash reporting for your apps in the field.  Automatically uploads dSYMs on release builds so your crashes are automatically symbolicated and organized for you to focus on the most critical ones.

## Testing

I don't think we as a community focus enough on testing. There are great tools available to us, and most are so easy to use we have no real excuse not to write at least some tests for our apps.

- [Kiwi](https://github.com/allending/Kiwi) - A great Rspec-style testing framework for iOS.  Built on top of SenTestingKit, so you just type `⌘U` to run your specs.  Also includes a completely robust mocking & stubbing library as well as assertions.
- [Specta](https://github.com/specta/specta) - A light-weight BDD framework very similar to Kiwi, but the expectation syntax has one major benefit over Kiwi:  everything is implicitly boxed like this:  `expect(items.count).to.equal(5)`.  There's no need to wrap `5` in an `NSNumber` like Kiwi does.  Use in conjunction with [Expecta](https://github.com/specta/expecta/) for a bunch of useful matchers.

The following are all various ways of performing end-to-end acceptance tests.  These tests will actually interact with your interface, touching buttons, scrolling, etc.  By nature these will be slower and more brittle, but testing in broad strokes is certainly helpful to see if all of the pieces fit together properly.

- [KIF](https://github.com/square/KIF)
- [Calabash](https://github.com/calabash/calabash-ios)
- [Zucchini](http://www.zucchiniframework.org/)
- [Frank](http://testingwithfrank.com/)
- [Bwoken](https://github.com/bendyworks/bwoken)

## Demos / Marketing

- [Reflector](http://www.airsquirrels.com/reflector/) ($) - Wirelessly mirror your iOS device on your Mac using Air Play.  Great for doing demos of applications on your computer.
- [Placeit](http://placeit.breezi.com) - A great collection of high res photos of people using devices, but the screens are templates that you can insert your own screenshots into.  Very cool, and great for displaying your app in a nice way on your website.

## App Sales Reporting

Of course you want to be able to see how much money you're making on your app, right?  There are a few solutions for this, but here are a couple that work well:

- [App Viz 2](http://www.ideaswarm.com/AppViz2.html) ($) - a really useful Mac app for tracking sales of your apps.  You run it locally and it logs in and downloads your sales reports.
- [App Annie](http://www.appannie.com/) - an online sales reporting tool.  I'm less comfortable giving my credentials to iTunes to a 3rd party, but it does keep the reports up to date for you so you don't have to run an app locally.

## Grab Bag

These tools don't have a defined category above, but deserve a mention nonetheless.

- [Quick Radar](http://www.quickradar.com/) - Submitting bug reports to Apple is our only way of making their tools better.  If you're frustrated by the lack of a feature, *you should be submitting a bug report*.  If you come across a bug, *you should be submitting a bug report*.  One has no right to complain if they have not yet filed a radar :).  With that in mind, submitting bug reports via [bugreporter](http://bugreporter.apple.com) feels like a trip back to 1995.  Quick Radar is an awesome little app that makes submitting bug reports super easy.  Sports automatic posting to open radar so others can see it, in addition to tweeting, and posting to App.net.  I use this app several times per week.

And there you have it.  A gigantic *wall of tools*.  Hopefully you learned about a few new ones you can add to your arsenal.  If you enjoyed this post, please check out my iOS screencasts over at [NSScreencast](http://nsscreencast.com).

[![NSScreencast - Weekly bite-sized videos on iOS development.](/images/nsscreencast-footer.png)](http://nsscreencast.com)










