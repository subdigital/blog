--- 
layout: post
title: Using CarrierWave with Mongoid
date: 2010-7-18
comments: true
link: false
---
<p>I'm moving a side project over to Rails 3, and I purposely chose a set of technologies that I hadn't used yet.</p>
<ul>
<li><a target="_blank" href="http://github.com/rails/rails">Rails 3</a></li>
<li><a target="_blank" href="http://mongoid.org/">Mongoid</a> (hosted on MongoHQ)</li>
<li><a target="_blank" href="http://haml-lang.com/">Haml</a></li>
<li><a target="_blank" href="http://github.com/jnicklas/carrierwave">CarrierWave</a> (for file uploads)</li>
</ul>
<p>I'll post about the general experience of this project later, but suffice it to say I'm liking this stack a lot. But this post is specifically about using CarrierWave to handle file uploads.</p>
<p>CarrierWave is similar to Paperclip, however it already supported Rails 3 &amp; Mongoid, so I decided to check it out. It creates the notion of &quot;uploaders&quot; and places them in a folder next to your models, controllers, &amp; views. Each uploader class defines the settings &amp; post-processing options for these uploads. I like keeping these separate from the model (instead of how Paperclip does it).</p>
<p>Here is a sample PicUploader that I'm using:</p>
<pre xml:lang="ruby">
class PicUploader &lt; CarrierWave::Uploader::Base
include CarrierWave::RMagick<br />   storage :s3<br /><br />   # Use Heroku's temp folder for uploads<br />   def cache_dir<br />      &quot;#{Rails.root}/tmp/uploads&quot;<br />   end<br />   process :resize_to_fit =&gt; [600, 600]<br />   <br />   version :tiny_thumb do<br />     process :resize_to_fill =&gt; [50, 50]<br />   end
version :thumb do<br />      process :resize_to_fill =&gt; [200, 200]<br />   end<br /><br />   def extension_white_list<br />      %w(jpg jpeg gif png)<br />   end<br />end
{% endcodeblock %}
<p>I'm storing these images in S3, but in order to process the file upload &amp; do post-processing on an image, it has to first be uploaded to a temp folder. I had to change this cache_dir to reflect heroku's temp folder.</p>
<p>Note also that it has support for RMagick (or MiniMagick) in order to do post-processing on the file to resize it to your needs. Here I'm resizing the file to best-fit a 600x600 square (maintaining aspect ratio). I also have 2 thumbnail sizes that clip the image in order to fill an exact square. All of this happens for me when I upload an image.</p>
<p>In order to utilize these files in your model, you have to import the necessary ORM adapter file so that when you save your model the filename gets saved with it. Here is an example model using the mongoid adapter.</p>
<pre xml:lang="ruby">
require 'app/uploaders/pic'
require 'carrierwave/orm/mongoid'
class Category
include Mongoid::Document
field :name, :type =&gt; String
field :description, :type =&gt; String
mount_uploader :photo, PicUploader
references_many :items
validates_presence_of :name, :description
end
{% endcodeblock %}
<p>When a category is saved, the uploader processes all of the sizes we need &amp; stores them all in S3. The category can then access these image URLS simply by doing this:</p>
<ul>
<li>`category.photo.url` (Full size)</li>
<li>`category.photo.thumb.url` (200x200)</li>
<li>`category.photo.tiny_thumb.url` (50x50)</li>
</ul>
<p>If you need to handle images in your site, you can't really beat the simplicity of this.</p>
<p>It hasn't all been sunshine &amp; roses, however. I have another model that accepts multiple images, so I made a Photo model in order to capture the file &amp; an associated caption. My Item model `embeds_many :photos`. It also is set up to `accept_nested_attributes_for :photos`, so that I can post multiple photos along with an item form.</p>
<p>Unfortunately, the mongoid adapter which gives you the `mount_uploader` behavior, only works when you call `save` directly on that object. Since my photos were being saved by it's parent document, the upload never happened. I<a target="_blank" href="http://github.com/jnicklas/carrierwave/issues#issue/81">t looks like this is a bug with CarrierWave</a>, and I'm looking at potential ways of contributing a fix. Right now, I'm manually pulling out the photos &amp; saving them one-by-one after an item is saved, but that isn't a great solution.</p>
