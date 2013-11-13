---
layout: post
title: "Creating a Fusion Drive"
date: 2013-11-12 20:32
comments: true
categories: 
---

![Fusion Drive](https://benpublic.s3.amazonaws.com/blog/fusion-drive.png)

I have a Late 2009 Core i7 27" iMac that was starting to feel old.  Many seemingly simple tasks would cause the OS to beachball, which generally made me not want to use the computer.

This slowness occurred despite the machine having a still respectable 2.8 GHz Core i7 processors.  In fact, running some benchmarks with Geekbench led me to believe the problem didn't lie with my CPU; it was my disk.

Unfortunately Geekbench doesn't have any disk benchmarks, so I used the relatively old Xbench as a baseline.  Compared with my Retina MacBook Pro with a 512 GB SSD, this drive was painfully slow.

I'd read about SSD upgrades in the 27" iMac but I was faced with the ultimate trade-off:  The raw speed of the SSD with the utter capacity of a traditional hard drive.

<!-- more -->

## Enter Fusion Drive

Late last year Apple released their Fusion Drive technology, backed by Core Storage.  With it, you can combine a traditional hard drive with an SSD and get the best of both worlds (theoretically).

The operating system will keep commonly-used files in fast SSD space, while shuttling larger, more dormant data over to the much slower platter drive.

While Apple sells a single unit that has both of these traits, the technology is available for anyone to combine two drives and get the same benefit.

## The Chosen Drives

I decided to keep my internal 2TB hard drive that I previously deemed slow.  The biggest reason for this is that the iMac drives come with a built-in temperature sensor, and replacing it means that the system won't know the temperature of the drive, causing the fans to run at full speed.  Apparently [you can use software to adjust the fan speed](http://www.hddfancontrol.com/), but I didn't want to bother with this (yet).

For the SSD I [already had](http://benscheirman.com/2013/02/in-search-of-a-fast-external-hard-drive/) an OWC Mercury 6G SSD at 240 GB that I figured would be better used here.  I won't be able to take advantage of the 6G speed of the Mercury due to my iMac being a bit too old, but it will still work.

![OWC Mercury 6G SSD 240GB](http://benscheirman.com/images/owc-240gb-ssd.jpeg)

Next, I needed to get a kit to install this in place of the optical drive in my iMac.  This might seem extreme, but I've only used it 3 or 4 times in the 3.5 years I've had this machine.  I can live without it.  OWC also sells a kit called [Data Doubler](http://eshop.macsales.com/item/Other%20World%20Computing/DDMMCL0GB/) that fits the bill perfectly.

Of course it goes without saying that I had backups for both drives.  For the 2TB I had a Time Machine backup that I intended to use for a restore later, and a complete image backup I took with [Super Duper](http://www.shirt-pocket.com/SuperDuper/SuperDuperDescription.html) the night before.

## Installation

In order to get into the iMac to replace the optical drive, you have to have a few tools:

- a suction cup handle (or pair of suction pullers)
- [torx t10 screwdriver](http://www.amazon.com/gp/product/B000KFV9C8/ref=as_li_ss_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=B000KFV9C8&linkCode=as2&tag=flux88com-20) (the OWC Data Doubler came with a small one)

I picked up this [FastCap Handle On Demand](http://www.amazon.com/gp/product/B001PBQ9K8/ref=as_li_ss_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=B001PBQ9K8&linkCode=as2&tag=flux88com-20) for about $10.  OWC also sells a smaller version of this.

![FastCap Handle On Demand](https://benpublic.s3.amazonaws.com/blog/handle-on-demand.png)

_Side note:  This handle is seriously strong. It could easily lift my desk without breaking suction._

I followed the [iFixit Hard Drive Replacement Guide](http://www.ifixit.com/Guide/iMac+Intel+27-Inch+EMC+2309+and+2374+Hard+Drive+Replacement/1634) for taking apart the iMac.  It wasn't quite as hard as I thought it would be. It took about an 20 minutes to get apart.  In this image you can see the screen removed, the optical drive removed and where the original hard drive sits.

![The iMac the the optical drive removed](https://benpublic.s3.amazonaws.com/blog/imac-drives.jpg)

The OWC Data Doubler harness fits exactly in the plastic frame left behind from the optical drive.  The drive plugs into the SATA y-cable provided by the OWC Data Doubler.  Notice that the temperature sensor that was attached to the optical drive was removed & attached to this enclosure.  The SSD will operate at normal temperatures and probably won't ever need additional cooling, but if you omit this cable the fan will just run at full speed.

![The SSD Installed](https://benpublic.s3.amazonaws.com/blog/imac-ssh-installed.jpg)

Once the drive was installed I reversed the steps in the guide to re-assemble the iMac.  Total installation time was about 50 minutes.

## Creating the Fusion Drive

I created a bootable USB drive with an 8GB USB stick beforehand with [Disk Maker X](http://liondiskmaker.com/).  If you hold down Option while the boot sound loads, it will prompt you to choose the boot drive.  Choosing the USB stick brought up the Mavericks installer.  In the menu, I selected **Terminal**.

It's important that this isn't done with a drive that is not the boot drive.  Since we're going to be erasing the partition & reformatting, we don't want to rip out the rug we're standing on.

Once in Terminal, I issued a few commands to create our fusion drive.  First, I got a list of the actual disk numbers:

```
> diskutil list
```

It printed a listing of your currently attached drives, like this:

```
/dev/disk0
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      GUID_partition_scheme                        *240.1 GB   disk0
   1:                        EFI EFI                     209.7 MB   disk0s1
   2:          Apple_CoreStorage                         239.7 GB   disk0s2
   3:                 Apple_Boot Boot OS X               134.2 MB   disk0s3
/dev/disk1
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      GUID_partition_scheme                        *2.0 TB     disk1
   1:                        EFI EFI                     209.7 MB   disk1s1
   2:          Apple_CoreStorage                         2.0 TB     disk1s2
   3:                 Apple_Boot Boot OS X               650.0 MB   disk1s3
/dev/disk2
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:                  Apple_HFS FusionDrive            *2.2 TB     disk2
```

Note that this shows my setup *after* creating the fusion drive, but you can clearly see the 2TB disk and the 240GB disk.  Make a note of these, in my case `/dev/disk0` and `/dev/disk1`.

Next I needed to create a logical volume group first, using those 2 drives.  We're using a `coreStorage` subcommand here, because that is the underlying technology behind "Fusion Drive".

```
> diskutil coreStorage create FusionDriveGroup /dev/disk0 /dev/disk1
```

I put the SSD first in this list, but I've read that it doesn't matter; Core Storage knows which drive is faster and will adjust itself accordingly.  YMMV. In the output of the above command is a UUID that I needed to copy for the next step.

```
> diskutil coreStorage createVolume <uuidfrombefore> jhfs+ "Fusion Drive" 100%
```

This tells the system to create a volume for that group we created, the format is going to be Journaled HFS+ and we want to fill 100% of the space.

Once the command finished, I had a single drive (in the eyes of the OS) to continue with the installation.

## Result

After installing Mavericks I restored users, settings, and applications from my 1.25 TB backup from the Time Machine (which took about 14 hours).  Once that finished I used it for a little bit.  It was clearly was faster, but how much faster?

Back to Xbench, I ran the same benchmark as before.  You can see the results side by side here, the new system on the **left**:

<a href="http://f.cl.ly/items/2r1A3G2w2R0a3p2b0y1l/Screen%20Shot%202013-11-06%20at%209.26.10%20PM.png">
<img alt="xbench scores, fusion drive on the left" src="https://benpublic.s3.amazonaws.com/blog/fusion-drive-xbench.jpg" border="0" /></a>

The scores here when taken at face value seem to indicate that the drive is about 20 times faster than before.  While this is true in the benchmark, real world performance likely won't be quite as good, as I don't think the benchmark copies any files large enough that would require "paging out" to the larger disk.  That said, this is clearly a performance win, and my system feels new again, which was the point of this whole endeavor.

Are there any downsides to doing this?  Of course there are.  I can think of a couple:

- Drives fail.  When you combine two physical drives that are part of a unit, then you are dependent on both drives not failing, which effectively doubles your risk.  Keep a backup.
- The Core Storage system could become corrupted, leaving the data unreadable on either drive.  Keep a backup.

I think both of these problems are sufficiently mitigated by having a solid backup strategy.


## Helpful Resources

I found a lot of help from the following:

- [http://www.youtube.com/watch?v=Lp7_AP0wc7s](http://www.youtube.com/watch?v=Lp7_AP0wc7s)
- [http://www.macworld.com/article/2014011/how-to-make-your-own-fusion-drive.html](http://www.macworld.com/article/2014011/how-to-make-your-own-fusion-drive.html)
- [Xbench](http://www.xbench.com/)

