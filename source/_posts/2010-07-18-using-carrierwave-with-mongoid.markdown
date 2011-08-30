--- 
layout: post
title: Using CarrierWave with Mongoid
date: 2010-7-18
comments: true
link: false
category: ruby
---
I'm moving a side project over to Rails 3, and I purposely chose a set of technologies that I hadn't used yet.

* <a target="_blank" href="http://github.com/rails/rails">Rails 3</a>
* <a target="_blank" href="http://mongoid.org/">Mongoid</a> (hosted on MongoHQ)
* <a target="_blank" href="http://haml-lang.com/">Haml</a>
* <a target="_blank" href="http://github.com/jnicklas/carrierwave">CarrierWave</a> (for file uploads)

I'll post about the general experience of this project later, but suffice it to say I'm liking this stack a lot. But this post is specifically about using CarrierWave to handle file uploads.

CarrierWave is similar to Paperclip, however it already supported Rails 3 & Mongoid, so I decided to check it out. It creates the notion of _uploaders_ and places them in a folder next to your models, controllers, views. Each uploader class defines the settings post-processing options for these uploads. I like keeping these separate from the model (instead of how Paperclip does it).

Here is a sample PicUploader that I'm using:

{% codeblock lang:ruby %}
class PicUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  storage :s3

  # Use Heroku's temp folder for uploads
  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end

  process :resize_to_fit => [600, 600]

  version :tiny_thumb do
    process :resize_to_fill => [50, 50]
  end

  version :thumb do
    process :resize_to_fill => [200, 200]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
{% endcodeblock %}

I'm storing these images in S3, but in order to process the file upload & do post-processing on an image, 
it has to first be uploaded to a temp folder. I had to change this `cache_dir` to reflect heroku's temp folder.

Note also that it has support for RMagick (or MiniMagick) in order to do post-processing on the file to resize 
it to your needs. Here I'm resizing the file to best-fit a 600x600 square (maintaining aspect ratio). I also 
have 2 thumbnail sizes that clip the image in order to fill an exact square. All of this happens for me when I 
upload an image.

In order to utilize these files in your model, you have to import the necessary ORM adapter file so that when 
you save your model the filename gets saved with it. Here is an example model using the mongoid adapter.

{% codeblock lang:ruby %}
require 'app/uploaders/pic'
require 'carrierwave/orm/mongoid'

class Category
  include Mongoid::Document
  field :name, :type => String
  field :description, :type => String
  mount_uploader :photo, PicUploader
  references_many :items
  validates_presence_of :name, :description
end
{% endcodeblock %}

When a category is saved, the uploader processes all of the sizes we need & stores them all in S3. The category can then access these image URLS simply by doing this:

* `category.photo.url` (Full size)
* `category.photo.thumb.url` (200x200)
* `category.photo.tiny_thumb.url` (50x50)

If you need to handle images in your site, you can't really beat the simplicity of this.

It hasn't all been sunshine & roses, however. I have another model that accepts multiple images, so I made a 
`Photo` model in order to capture the file & an associated caption. My Item model `embeds_many :photos`. 
It also is set up to `accept_nested_attributes_for :photos`, so that I can post multiple photos along with 
an item form.

Unfortunately, the mongoid adapter which gives you the `mount_uploader` behavior, only works when you call 
`save` directly on that object. Since my photos were being saved by it's parent document, the upload never 
happened. It <a target="_blank" href="http://github.com/jnicklas/carrierwave/issues#issue/81">looks like this is a bug with CarrierWave</a>, and I'm looking at potential ways of contributing a fix. Right now, I'm manually pulling out the photos & saving them one-by-one after an item is saved, but that isn't a great solution.
