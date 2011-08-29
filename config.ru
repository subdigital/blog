require 'bundler/setup'
require 'sinatra/base'

# The project root directory
$root = ::File.dirname(__FILE__)

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

# use Rack::Rewrite do
#  r301 %r{.*}, 'http://benscheirman.com$&', :if => Proc.new {|rack_env|
#    rack_env['SERVER_NAME'] != 'benscheirman.com' && ENV['RACK_ENV'] == 'production'
#  }
#
#  r301 %r{^/(\d{4}/\d{2}/.+/?)$}, '/blog/$1'
#  r301 %r{^(.+)/$}, '$1'
#  
# end

run SinatraStaticServer
