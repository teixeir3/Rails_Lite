class Route
  attr_reader :pattern, :http_method, :controller_class, :action_name

  def initialize(pattern, http_method, controller_class, action_name)
    @pattern, @http_method = pattern, http_method
    @controller_class, @action_name = controller_class, action_name
  end

  # checks if pattern matches path and method matches request method
  def matches?(req)
    http_method == req.request_method.downcase.to_sym && @pattern.match(req.path)
  end

  # use pattern to pull out route params (save for later?)
  # instantiate controller and call controller action
  def run(req, res)
    # @params = req.path
    match_obj = pattern.match(req.path)
    match_keys =  match_obj.names
    route_params = {}
    match_keys.each do |key|
      route_params[key] = match_obj[key]
    end
    @controller_class.new(req, res, route_params).invoke_action(@action_name)
  end
end

class Router
  attr_reader :routes

  def initialize
    @routes = []
  end

  # simply adds a new route to the list of routes
  def add_route(pattern, method, controller_class, action_name)
    @routes << Route.new(pattern, method, controller_class, action_name)
  end

  # evaluate the proc in the context of the instance
  # for syntactic sugar :)
  def draw(&proc)
    # proc.call(self)
    self.instance_eval(&proc)
  end

  # make each of these methods that
  # when called add route
  [:get, :post, :put, :delete].each do |http_method|
    define_method(http_method) do |pattern, controller, action|
      add_route(pattern, http_method, controller, action)
    end
  end

  # should return the route that matches this request
  def match(req)
    # @routes.select{|route| route.matches?(req) }
    matched_route = nil

    @routes.each do |route|
      matched_route = (route.matches?(req)) ? route : nil
      break if matched_route
    end
    matched_route
  end

  # NOT TESTED
  # either throw 404 or call run on a matched route
  def run(req, res)
    matched_route = self.match(req)
    if matched_route
      matched_route.run(req, res)
    else
      res.status=404
    end
  end
end
