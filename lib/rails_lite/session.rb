require 'json'
require 'webrick'
require 'debugger'

class Session


  # find the cookie for this app
  # deserialize the cookie into a hash
  def initialize(req)
    # debugger
    # req.cookies[:rails_lite_app]
    # parsed_cookies = WEBrick::Cookie.parse(req.cookies)
    cook = req.cookies.select { |cookie| cookie.name == '_rails_lite_app'}.first

    @session = (cook.nil?) ? {} : JSON::parse(cook.value)

  end

  def [](key)
    @session[key]
  end

  def []=(key, val)
    @session[key] = val
  end

  # serialize the hash into json and save in a cookie
  # add to the responses cookies
  #
  # will make a new cookie named '_rails_lite_app', set the value to the JSON serialized content of the hash, and add this cookie to response.cookies.
  def store_session(res)

    cookie = WEBrick::Cookie.new('_rails_lite_app', @session.to_json)
    res.cookies << cookie
  end
end
