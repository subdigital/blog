require 'bundler/setup'
require 'sinatra/base'
require 'rack/rewrite'

# The project root directory
$root = ::File.dirname(__FILE__)

use Rack::Rewrite do
 r301 %r{.*}, 'http://benscheirman.com$&', :if => Proc.new {|rack_env|
   rack_env['SERVER_NAME'] != 'benscheirman.com' && ENV['RACK_ENV'] == 'production'
 }

  # redirect /blog/2004/10/* to just /2004/10/*
  r301 %r{^/blog/(\d{4}/\d{2}/.*)$}, '/$1'

  # redirect /blog/2004/10/15/* to just /2004/10/*
  r301 %r{^/(\d{4}/\d{2}/)\d{2}/(.*)$}, '/$1$2'

  # redirect wordpress feed request to the new url
  r301 '/feed', '/atom.xml'

  r301 '/about', '/about-me'

  # redirect giggle touch url
  r301 /^\/giggle-?touch$/, 'http://appsites.heroku.com/giggletouch'

  # remove trailing slashes
  r301 %r{^(.+)/$}, '$1'

end

class SinatraStaticServer < Sinatra::Base

  get(/.+/) do
    send_sinatra_file(request.path) {404}
  end

  not_found do
    send_sinatra_file('404.html') {"Sorry, I cannot find #{request.path}"}
  end

  def send_sinatra_file(path, &missing_file_block)
    file_path = File.join(File.dirname(__FILE__), 'public',  path)
    file_path = File.join(file_path, 'index.html') unless file_path =~ /\.[a-z]+$/i  
    File.exist?(file_path) ? send_file(file_path) : missing_file_block.call
  end

end

run SinatraStaticServer
