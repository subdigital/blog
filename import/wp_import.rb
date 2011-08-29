require 'fileutils'
require 'date'
require 'yaml'
require 'rexml/document'
include REXML


class WordpressImporter
  attr_reader :test_mode

  def initialize(file_path, test_mode)
    puts "Initializing with #{file_path}"
    @doc = Document.new File.new(file_path)
    @test_mode = test_mode
  end

  def parse
    puts "Parsing the XML file..."
    @doc.elements.each("rss/channel/item[wp:status = 'publish' and wp:post_type = 'post']") do |e|
      post = e.elements
      slug = post['wp:post_name'].text
      date = DateTime.parse(post['wp:post_date'].text)
      name = "%02d-%02d-%02d-%s.markdown" % [date.year, date.month, date.day, slug]
      date_string = date.year.to_s + "-" + date.month.to_s + '-' + date.day.to_s
      content_text = post['content:encoded'].text

      content = content_text.encode("UTF-8")

      content = replace_code_blocks content
      #content = replace_header_tags content
      content = fetch_images_and_correct_links content

      puts "Converting: #{name}"

      data = {
          'layout' => 'post',
          'title' => post['title'].text,
          'date' => date_string,
          'comments' => true,
          'categories' => nil,
          'link' => false
       }.delete_if { |k,v| v.nil? || v == ''}.to_yaml


       File.open("_posts/#{name}", "w") do |f|
           f.puts data
           f.puts "---"
           f.puts content
       end unless test_mode
    end

  end

  def replace_code_blocks(content)
    content = content.gsub(/<code>(.*?)<\/code>/, '`\1`')
    content = content.gsub(/<pre>/, '{% codeblock %}')
    content = content.gsub(/<pre (\w+="[^"]*"\s)*lang="([^"]+)"[^>]*>/, '{% codeblock lang:\2 %}')
    content = content.gsub(/<pre (\w+="[^"]*"\s*)*>/, '{% codeblock %}')
    content = content.gsub(/<\/pre>/m, '{% endcodeblock %}')
    content
  end

  def replace_header_tags(content)
    # Replace <h1> with #, <h2> with ## and so on...
    (1..3).each do |i|
      content = content.gsub(/<h#{i}>([^<]*)<\/h#{i}>/, ('#'*i) + ' \1')
    end
    content
  end

  def image_needs_fetching?(url)
    ok_domains = %W{amazonaws.com flickr.com}
    ok_domains.each { |ok_domain| return false if url.include? ok_domain }
    return true
  end

  def filename_for_url(image_url)
    filename = File.basename(image_url)
    while File.exists? "_images/#{filename}"
      parts = filename.split(".")
      parts[-2] = parts[-2] << "_"
     filename = parts.join(".")
    end
    "_images/#{filename}"
  end

  def download(full_url, to_here)
    require 'open-uri'
    write_out = open(to_here, "wb")
    write_out.write(open(full_url).read)
    write_out.close
  end  

  def fetch_image(image_url)
    image_url = image_url.gsub(/\[/, '%5B').gsub(/\]/, '%5D')

    filename = filename_for_url image_url
    puts "Fetching #{image_url} and storing in #{filename}"
    download(image_url, filename)
    filename
  rescue OpenURI::HTTPError
    puts "Error fetching #{image_url}"
    return nil
  rescue
    puts "TIMEOUT for #{image_url}"
    return nil
  end

  def fetch_images_and_correct_links(content)
    replacements = {}
    content.scan /(<img (\w+="[^"]+"\s+)*src="([^"]+)" (\w+="[^"]+"\s*)*\s*\/?>)/ do |matches|
      image_tag = matches.shift
      before_attributes = matches.shift
      url = matches.shift
      after_attributes = matches.shift

      if image_needs_fetching?(url)
        new_path = fetch_image(url)
        unless new_path.nil?
          new_url = new_path.gsub(/^_/, '/')
          attribs = "#{before_attributes} #{after_attributes}"
          replacements[image_tag] = "<img src=\"#{new_url}\" #{attribs} />"
        end
      end
    end

    replacements.each do |key, value| 
      puts "Replacing image tag #{key} with #{value}"
      content = content.sub(key, value)
    end
    content
  end

end

if __FILE__ == $0
  file_path = ARGV[0]

  def test_mode?
    ENV['test'] == '1'
  end

  if file_path.nil?
    puts "You must supply an argument for the XML file to import."
    exit(1)
  end

  unless File.exists?(file_path)
    puts "The file #{file_path} does not exist"
    exit(1)
  end


  importer = WordpressImporter.new(file_path, test_mode?)
  puts "* RUNNING IN TEST MODE *" if test_mode?

  FileUtils.mkdir_p "_posts"
  FileUtils.mkdir_p "_images"

  importer.parse
end

