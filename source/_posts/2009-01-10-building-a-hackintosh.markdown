--- 
layout: post
title: Building a Hackintosh
date: 2009-1-10
comments: true
link: false
---
<p>I'm writing this post on my new hackintosh - that is - OS X Leopard running on PC hardware. So far the system is pretty stable and I'm liking it a lot.</p>
<p><img src="/images/IMG_0734_.jpg"  alt="IMG_0734.JPG"  /></p>
<p><br />
<img src="/images/leopard_.png"  alt="osx desktop"  /></p>
<p>Running OS X on PC hardware isn't always easy, I just happened to have the lucky mix of hardware that pretty much just works. The motherboard is the most critical determining factor.</p>
<h2>My hardware</h2>
<ul>
<li><a href="http://www.zipzoomfly.com/jsp/ProductDetail.jsp?ProductCode=10008509-OP&#38;prodlist=celebros">Gigabyte EP35-DS3L</a> ($70)</li>
<li><a href="http://">Intel Core 2 Duo E8400 @ 3.0ghz</a> ($164)</li>
<li><a href="http://www.newegg.com/Product/Product.aspx?Item=N82E16814150247">NVidia 8600GT 512MB</a> ($69)</li>
<li><a href="http://www.newegg.com/Product/Product.aspx?Item=N82E16820145184">4GB Corsair Memory</a> ($55)</li>
<li>Western Digital 500GB MyBook USB Hard drive</li>
</ul>
<p>You could easily build a PC based on this hardware for under $500. We have sound, lan, any hard drive will do, a decent video card, a fast processor, and 4 GB of memory. I'm using this on my existing Vista machine, so I decided to install on an external drive. Dual booting is possible, and with USB it's easy: just unplug the USB drive to boot in windows. Other options allow you to have a boot menu to choose the OS.</p>
<h2>Where to start</h2>
<p>The definitive place to learn how to do this is the <a href="http://forum.insanelymac.com/">Insanely Mac Forums</a>. Expect to read a TON before you start. Spend most of your time initially in the OSx86 forum.</p>
<h2>The software</h2>
<ul>
<li>I got most of my help from <a href="http://forum.insanelymac.com/index.php?showtopic=86167">this tutorial</a>. It is based on this same hardware, and pretty much worked right away for me.</li>
<li>Kalyway 10.5.2 OS X Installer<br />
You can get this from the usual places. I originally used this install and it worked okay, however I noticed a handful of application crashes and the occasional GSOD (Grey screen of death). We're going to use this for the initial boot and to make a utility install. Utility installs will help when things go wrong, like for example if you decide to use a driver (known as kernel extensions or "kexts") and the kext causes a kernel panic on boot, then you can boot in the utility partition and fix it.</li>
<li>Retail Leopard OS X 10.5.5<br />
You can get this at an Apple store, ebay, craigslist, or the usual places. I found one on craigslist for $50.</li>
<li>10.5.6 combo updater</li>
<li>v4.4 utility package from the tutorial author</li>
</ul>
<p>You can get the combo updater and the utility package from the tutorial post. Follow the tutorial and you should be fine.</p>
<h2>BIOS</h2>
<p>Having an updated BIOS is <em>usually</em> a good idea. In my case I had to update to F5. I also had to enable SATA AHCI, which is supposed to increase the reliability of OS X. This made Vista blue screen on boot. Apparently Vista removes unused drivers to speed up boot time. <a href="http://www.itwriting.com/blog/288-enabling-ahci-on-vista.html">Enabling a setting in the registry</a> fixed this.</p>
<h2>Create a utility install with Kalyway</h2>
<p>This is something that was confusing to me. Sort of a chicken and egg problem, but you need to install the retail install from an existing OS X installation. I used the Kalyway installer. I shrunk a partition in Windows by 40GB, then rebooted with the Kalyway DVD. It takes a while, but eventually the OS X installer came up. You then go to Disk Utility and format the partition. Choose Mac Journaled as the format. OSX should install after 10-15 minutes. This is where some folks have hardware issues. If your sound, lan, or video cards don't work, then you have to roll up your sleeves and do some manual hacking. I lucked out and mine pretty much worked. It wasn't very stable though.</p>
<p>Once you're in, you can continue to boot to this install using the boot DVD. I was unable to get any bootloaders to work. This utility install will be helpful to fix any problems that arise from tinkering with the main OS.</p>
<p>From there, I followed this guide which provided me with most of what I needed to get the retail DVD installed, update to 10.5.6, run the postpatch.sh script and reboot. Then I ran the EFI hack which allows you to boot directly into OS X. At this point I set the USB drive to be first priority and viola! Leopard booted.</p>
<h2>Getting 3D Graphics working</h2>
<p>Upon booting the first time the graphics were sluggish and it could only run at 10204x768. There are a number of posts on the topic of video drivers, the problem is some of them are dated. NVinject worked for my 10.5.2 Kalyway install, but did not work for the 10.5.6 retail. Instead I had to use EFI Studio (found in the v4.4 package from earlier) and selected the 8600 GT 512 MB item.<img src="/images/efistudio_.png"  alt="efistudio.png"  /></p>
<p>Then I clicked "Add Device" which brought up this window:</p>
<p><img src="/images/efistudio2_.png"  alt="efistudio2.png"  /></p>
<p>Then click "write to com.apple.Boot.plist", reboot and you're good! To get sound working I had to install the <a href="http://forum.insanelymac.com/index.php?act=attach&#38;type=post&#38;id=20698">ALC888 kext</a>.</p>
<h2>Installing kexts</h2>
<p>Installing kexts is basically copying a file to /System/Library/Extensions, fixing up the permissions on the file(s) with</p>
{% codeblock %}
sudo chmod -R 755 /System/Library/Extensions/yourkext.kext<br />sudo chown -R root:wheel /System/Library/Extensions/yourkext.kext
{% endcodeblock %}
<p>then you need to remove the kext caches like so:</p>
{% codeblock %}
sudo rm -R /System/Library/Extensions.kextcache<br />sudo rm -R /System/Library/Extensions.mkext
{% endcodeblock %}
<p>Reboot and cross your fingers! If you get a kernel panic, then just boot in single user mode (press F8 at boot and type -s at the prompt) (or boot your utility install) and remove the offending kexts.</p>
<p>I found it easy to automate this process using <a href="http://cheetha.net/">KextHelper</a>.</p>
<p>At this point I have a fully retail copy of 10.5.6, and I'm a "Mac Pro" in the eyes of Apple. This means (I think) that I can update to future versions with little to no tweaking!</p>
<p><br />
<img src="/images/about-this-mac_.png"  alt="about-this-mac.png"  /></p>
<p><br />
<img src="/images/about-this-mac2_.png"  alt="about-this-mac2.png"  /></p>
<p>If I were to build a Mac Pro from apple.com with these specs, <strong>it would cost near $3000!</strong></p>
<h2>Things still to figure out</h2>
<p>My Microsoft Lifecam v1000 doesn't quite work. I got it to work in iChat for a few minutes, but doesn't work in Photobooth or Skype. This is a minor setback, as I can just buy a supported one.</p>
<p>My RAID array isn't visible. I have 2x250gb drives in RAID 1 (stripe). I need to investigate &#38; see if there are drivers for my SATA raid card. All in all it's a small loss.</p>
<p>VNC comes built-in with 10.5.6, however it's SO SLOOOOWWW over the internet. Remote Desktop is far superior because they aren't streaming bitmaps, it is actually rendering a desktop locally &#38; transmitting state changes. I really want to find a better solution for accessing my PC remotely.</p>
<h2>Conclusion</h2>
<p>This system has been really stable so far. I've had one crash, and I'm not sure what caused it, but a week has gone by with no lockups or crashes whatsoever. I'm really close to ditching my Vista install and put this on my fast Western Digital Raptor main drive.</p>
<p>&nbsp;&#160;</p>
