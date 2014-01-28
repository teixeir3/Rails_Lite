require 'webrick'


# root = File.expand_path '/'
server = WEBrick::HTTPServer.new :Port => 8080# , :DocumentRoot => root

trap('INT') { server.shutdown }



server.mount_proc '/' do |req, res|
  res.content_type = 'text/text'
  res.body = req.path
end

server.start

# class Simple < WEBrick::HTTPServlet::AbstractServlet
#
#   def do_GET request, response
#
#
#   end
#
# end

#and a proc, which are passed to the HTTPRequest and HTTPResponse to fill out
#
# HTTPRequest.content_type = text/text(mime type)
# body to HTTPRequest.path
# Add