---
layout: post
title: "In Search of a Fast External Hard Drive"
date: 2013-02-02 11:46
comments: true
categories: 
---

Ever since I upgraded to a retina MacBook Pro, I knew I'd have to come up with a new strategy for storing data. Even after upgrading to the 512GB SSD, I'm still running out of space.
With hundreds of gigabytes for pictures, music, videos, and games a 512GB SSD is perfectly reasonable.  But now that [NSScreencast](http://nsscreencast.com)
 is nearing a year old I have more data than I can store on a single drive.  Another nuissance was transferring these videos over to my iMac for editing.  
A typical 20 minute screencast of mine will eat up nearly 8 gigabytes before encoding, and transfering a file like this over Wi-Fi is painfully slow.

On my previous MacBook Pro I opted to remove the superdrive and install a 2nd 7200 RPM drive for larger storage.  This worked well, but the retina MacBook Pro has no such capability,
so I went on the lookout for an external drive to store NSScreencast videos.

<!--more-->

## Requirement #1: Speed

The first requirement was that the drive had to be fast.  Ideally I'd record directly to the drive and then I'd be free to move it over to the iMac and just plug it in.

## Requirement #2: Connections

My MacBook Pro has Thuderbolt, which, at 10 Gb/s, is very attractive.  However my late-2009 iMac does not have Thunderbolt, this severely limits my options.

My MBP has USB 3.0 ports, and most (if not all) USB 3.0 drives are backward compatible with USB 2.0.  For reference, USB 3.0 speed is 5Gb/s, and USB 2.0 is 480 Mb/s.

This means, provided we had a fast enough drive, a Thunderbolt connection could yield up to 1.25 Gigabytes per second data transfer.  This is crazy fast, and unfortunately there isn't a drive on the planet (yet) that reads or writes this fast.

## Requirement #3: Size

Most of the time when going for an external drive it is for backup reasons, so size is king.  But in my case I was willing to forego size for the right drive.


## The Drives

Initially I was eyeing this [Buffalo 1TB Thunderbolt USB 3.0/2.0 Drive](http://www.amazon.com/BUFFALO-MiniStation-Thunderbolt-Portable-Drive/dp/B008D4X9UI/) because it seemed like it would satisfy both connectivity and size requirements.  But on further inspection, they seem to have just placed a 5400 RPM drive in here.  A few reviewers posted their transfer speeds, and looks to be around 80 MB/s.  Considering that a 1TB external USB 3.0 drive is only around $100 these days, this drive (at $200), was clearly not a good choice.

I recently got a [USB 3.0 Western Digital 2TB My Passport](http://www.amazon.com/Passport-Portable-External-Drive-Storage/dp/B005HMKKH4/) for time machine backups, which replaced an older 7200 RPM drive in a 3rd party USB enclosure.

![Western Digital My Passport 2TB USB 3.0 drive](/images/wdpassport2tb.png)

The 7200 RPM drive was my baseline.  It's been a handy external drive for a long time, but being USB 2.0, it was going to be the slowest possible choice.

I realized that to saturate USB 3.0 at 5Gb/s, I'd need a drive that can write that fast.  SSD's are the clear choice here, and after a bit of research I picked up a [240GB Mercury Electra 6Gbps SSD](http://eshop.macsales.com/item/OWC/SSDEX6G240/) from [OWC](http://macsales.com).  This drive boasts write speeds of up to 500 MB/s!

![OWC Mercury Electra SSD - 240GB](/images/owc-240gb-ssd.jpeg)

  Along with the drive I purchased their [USB 3.0 / 2.0 enclosure](http://eshop.macsales.com/shop/USB2/OWC_Express).

![OWC USB 3.0 Enclosure](/images/owc-enclosure.jpeg)

So the main question is, is it worth it to buy such an expensive drive for your external drive needs?  Time to run some benchmarks.

![The drives](/images/drives-to-test.jpeg)

## The Tests

I used the freely available [AJA Disk Test](http://www.aja.com/en/products/software/) tool to perform a benchmark. I used the 1920x1080 10-bit video file test with a size of 16 GB.  The file is written to disk and then read back again.  All drives were empty when performing the test.

### Western Digital Raptor 320GB 7200 RPM drive via USB 2.0

This was obviously the slowest of the bunch, but for comparison, this is my baseline.  The drive boasted a write speed of **38 MB/s** and a read speed of **41 MB/s**.

![WD 7200 RPM drive results](/images/raptor-aja-disk-test.png)

### Western Digital 2TB My Passport (USB 3.0)

This drive posted better results that the previous drive, but it doesn't even come close to saturating the USB 3.0 pipe, which could potentially yield around 625 MB/s.  Doing the same test above, this drive benchmarked a write speed of **94.2 MB/s** and a read speed of **92.9 MB/s**.

![WD 2TB My Passport USB 3.0 results](/images//wdpassport-aja-disk-test.png)

### OWC Mercury Electra 6G SSD - 240GB via USB 3.0

This drive is slightly held back by being on a USB bus rather than direct SATA connection, but still posted impressive speeds.  The test resulted in a **284.3 MB/s** write speed and a **250.7 MB/s** read speed.

![OWC Mercury Electra SSD - USB 3.0](/images/owc-aja-disk-test.png)

## Conclusion

Here are the read & write speeds for each drive side by side.  The result is clear.

![Drive test results](/images/drive-test-graph.png)

The SSD version is more than twice as fast than any packaged USB 3.0 drive out there.  In addition, it doesn't suffer from seek delay, some random access should be much quicker as well.  I did noticed that OWC sells their own external SSD (which I wish I had seen before purchasing mine) but I suspect it will receive similar speeds, and the combo I purchased is actually about $80 cheaper.

SSDs continue to kick major ass, so here's to hoping they drop in price.
