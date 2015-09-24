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

    path ||= params[:path]
    if action_methods.include? path
      send path and return
    end

    if template_exists?(path, [controller_name])
      render "#{controller_name}/#{path}" and return
    end

    if Divert.configuration.save_to_db && (redirect = Redirect.hit(request.fullpath))
      redirect_to redirect
    else
      unless template_exists? 'divert', [controller_name]
        render text:"Missing divert view: #{controller_name}/divert.html.erb", :status => 404 and return
      end
      render "#{controller_name}/divert", :status => 404 and return
    end
  end
end

class ActionDispatch::Routing::Mapper
  def divert_with controller
    get ':action' => controller.to_s
    get '*path' => "#{controller}#action_missing", :format => false
  end
end
