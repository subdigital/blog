---
layout: page
title: "Contact"
date: 2011-08-30 08:31
comments: false
sharing: false
footer: true
---

If you need to get in touch with me, you can reach me anywhere below:

<table class="contact" style="background-color: #fff; border: solid 1px #ddd; padding:
10px" cellspacing="8">
  <tr>
    <td>Email</td>
    <td><span id="addr"></span></td>
  </tr>
  <tr>
    <td>Twitter</td>
    <td><a href="http://twitter.com/subdigital"
target="_blank">@subdigital</a></td>
  <tr>
    <td>Skype</td>
    <td>benscheirman</td>
  </tr>
</table>

<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>

<script type="text/javascript">
$(function() {
  var addy = "ben" + "@";
  addy = addy + "scheirman" + "." + "com";
  mlink = $("<a href='mailto:" + addy + "'>" + addy + "</a>");
  mlink.appendTo($("#addr"));
});
</script>
