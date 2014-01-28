require 'erb'
require 'active_support/inflector'
require 'active_support/core_ext'
require_relative 'params'
require_relative 'session'


class ControllerBase
  attr_reader :params, :req, :res

  # setup the controller
  def initialize(req, res, route_params = {})
    @req, @res, @params = req, res, route_params
    @already_built_response = false
  end

  # populate the response with content
  # set the responses content type to the given type
  # later raise an error if the developer tries to double render
  def render_content(content, type)
    raise "Content already rendered" if self.already_rendered?

    @res.content_type = type
    @res.body = content
    session.store_session(@res)
    @already_built_response = true
  end

  # helper method to alias @already_rendered
  def already_rendered?
    @already_built_response
  end

  # set the response status code and header
  def redirect_to(url)
    # also set @already_built_response
    # HTTP status code and the location header
    raise "Content already rendered" if self.already_rendered?
    @res.status = 302
    @res.header["location"] = url

    session.store_session(@res)
    @already_built_response = true
  end


  # use ERB and binding to evaluate templates
  # pass the rendered html to render_content
  def render(template_name)
    parsed_class_name = self.class.to_s.underscore
    template_text = File.read("views/#{parsed_class_name}/#{template_name}.html.erb")
    new_template = ERB.new(template_text)
    template_result = new_template.result(binding)

    self.render_content(template_result, 'text/html')
    # template_result.eval()
  end

  # method exposing a `Session` object
  def session
     # @session ||= Session.new(JSON::parse(@req))
    @session ||= Session.new(@req)
  end

  # use this with the router to call action_name (:index, :show, :create...)
  def invoke_action(name)
  end
end
