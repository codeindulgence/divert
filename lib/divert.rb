require "divert/engine"
require "divert/configuration"

module Divert

  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  def action_missing path = nil
    binding.pry
    controller = Divert.configuration.controller || controller_name

    path ||= params[:path]
    if action_methods.include? path
      send path and return
    end

    if template_exists?(path, [controller])
      render "#{controller}/#{path}" and return
    end

    if Divert.configuration.save_to_db && (redirect = Redirect.hit(request.fullpath))
      redirect_to redirect
    else
      unless template_exists? 'divert', [controller]
        render text:"Missing divert view: #{controller}/divert.html.erb", :status => 404 and return
      end
      render "#{controller}/divert", :status => 404 and return
    end
  end

  alias_method :divert, :action_missing
end

class ActionDispatch::Routing::Mapper
  def divert_with controller
    # Set controller in configuration if not already set
    Divert.configuration.controller ||= controller.to_s
    get ':action' => controller.to_s
    get '*path' => "#{controller}#action_missing", :format => false
  end
end
