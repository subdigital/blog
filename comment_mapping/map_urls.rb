require 'net/http'
require 'uri'

updates = []

File.open("mapping.csv", "r") do |f|
  while(comment_url = f.gets) do
    comment_url = comment_url.gsub(/\r\n/, '')
    print "#{comment_url}..."
    uri = URI.parse comment_url
    response = Net::HTTP.get_response(uri)
    case response
    when Net::HTTPSuccess
      puts "OK"
    when Net::HTTPRedirection
      new_url = response['location']
      puts "301"
      puts " --> New url is: #{new_url}"
      updates << "#{comment_url}, http://benscheirman.com#{new_url}\n"
    end
    puts
  end
end

content = updates.join("\n")
puts "The updates are:\n #{content}"

File.open('updated.csv', 'w') do |f|
  updates.each do |line|
    f.puts line
  end
end
