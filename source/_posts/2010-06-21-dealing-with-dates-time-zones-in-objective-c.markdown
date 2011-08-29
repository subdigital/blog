--- 
layout: post
title: Dealing with Dates & Time Zones in Objective-C
date: 2010-6-21
comments: true
link: false
---
<p>Date formatting is always one of those areas (especially in a newer language) where you continually need to look it up to do it the right way.<p>
<p>In an application that I'm building I have a need to deal with dates coming from an XML feed, so I need to parse them as a string.  I also need to be able to display dates in a different format that I'm given (or translate them between various time zones) so clearly I can't just treat the value as a string.<p>
<p>For a complete reference check out the official documentation on <a href="http://developer.apple.com/mac/library/documentation/cocoa/conceptual/dataformatting/articles/dfDateFormatting10_4.html" target="_blank">NSDateFormatter</a>.</p>
<h2>String &rarr; Date</h2>
<p>To convert from an NSString to NSDate, you have to create an `NSDateFormatter` and set the date format to a pattern matching your expected date.  The format I was expected was like this:</p>
<blockquote>
`Sun, 20 Jun 2010 20:28:00 GMT`
</blockquote>
<p>In order to set up our format strings, we can reference the official <a href="http://unicode.org/reports/tr35/tr35-6.html#Date_Format_Patterns" target="_blank">Unicode standard date formatting tokens</a>.  For my needs, this turned out to be `EEE, dd MMM yyyy HH:mm:ss zzzz`.  Plugging this into `NSDateFormatter` is pretty easy:</p>
<blockquote>
`Sun, 20 Jun 2010 20:28:00 GMT`
</blockquote>
{% codeblock %}-(NSDate *)dateFromString:(NSString *)dateString {
NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
[formatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss zzz"];
return [formatter dateFromString:dateString];
}{% endcodeblock %}
<p>Sometimes we aren't lucky enough to have time zone information passed as part of the string.  In that case, you may need to explicitly tell the formatter about your time zone:</p>
{% codeblock %}[formatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];{% endcodeblock %}
<h2>Date &rarr; String</h2>
<p>To convert from an NSDate to an NSString, it is quite similar to the method above, except your date format string is the format that you <em>want</em> your string to look like.  In my case, I want a short date to be displayed in the corner of a `UITableViewCell`, so my formatting code looks like this:</p>
{% codeblock %}NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
[formatter setDateFormat:@"dd-MMM"];
cell.dateLabel.text = [formatter stringFromDate:item.pubDate];
[formatter release];{% endcodeblock %}
<p>I chose to use a short word form for the month, because this app might be used by international folks and you might not be able to distinguish a date like `06/10`.  You could of course examine the locale of the user and set the date format accordingly, but I think this is an easier way out :).</p>
<h2>Date Format Symbols</h2>
<p>The table from the unicode date formatting page should be enough for you to build your own desired date format string...<p>
<table cellspacing="0" cellpadding="5" border="1" style="border-collapse: collapse;">
<thead>
<tr style="background-color: #8bf">
<th width="50%">Pattern</th>
<th width="50%">Result (in a particular locale)</th>
</tr>
</thead>
<tbody>
<tr>
<td width="50%">yyyy.MM.dd G 'at' HH:mm:ss zzz</td>
<td width="50%">1996.07.10 AD at 15:08:56 PDT</td>
</tr>
<tr>
<td width="50%">EEE, MMM d, ''yy</td>
<td width="50%">Wed, July 10, '96</td>
</tr>
<tr>
<td width="50%">h:mm a</td>
<td width="50%">12:08 PM</td>
</tr>
<tr>
<td width="50%">hh 'o''clock' a, zzzz</td>
<td width="50%">12 o'clock PM, Pacific Daylight Time</td>
</tr>
<tr>
<td width="50%">K:mm a, z</td>
<td width="50%">0:00 PM, PST</td>
</tr>
<tr>
<td width="50%">yyyyy.MMMM.dd GGG hh:mm aaa</td>
<td width="50%">01996.July.10 AD 12:08 PM</td>
</tr>
</tbody></table>
<p>Hope this is useful to someone out there.</p>
