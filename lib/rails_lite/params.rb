require 'uri'

class Params
  # use your initialize to merge params from
  # 1. query string
  # 2. post body
  # 3. route params
  def initialize(req, route_params = {})
    @params = {}

    self.parse_www_encoded_form(req.query_string)
  end

  def [](key)
  end

  def to_s
  end

  private
  # this should return deeply nested hash
  # argument format
  # user[address][street]=main&user[address][zip]=89436
  # should return
  # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
  def parse_www_encoded_form(www_encoded_form)
    # parse a URI encoded string, setting keys and values in the @params hash.
    www_decoded_form = URI.decode_www_form(www_encoded_form)

    www_decoded_form.each do |param_pair|
      @params[param_pair.first]=param_pair.last
    end

  end

  # this should return an array
  # user[address][street] should return ['user', 'address', 'street']
  def parse_key(key)
  end
end
