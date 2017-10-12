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
    controller = Divert.configuration.controller || controller_name

    path ||= params[:path]
    if action_methods.include? path
      send path and return
    end

    #use rails template_exists? method to check if view exists in the view dir
    #corresponding to the controller name. If so, render the view.
    if template_exists?(path, [controller])
      render "#{controller}/#{path}" and return
    end

    if Divert.configuration.save_to_db && (redirect = Redirect.hit(request.fullpath))
      if Divert.configuration.redirect_clientside

        unless template_exists? 'divert_clientside.html.erb', [controller]
          render text:"Missing divert view: #{controller}/divert_clientside.html.erb", :status => 404 and return
        else
          render "#{controller}/divert_clientside.html.erb", :layout => false, :status => 404 and return
        end

      else
        redirect_to redirect
      end
    else
      unless template_exists? 'divert.html.erb', [controller]
        render text:"Missing divert view: #{controller}/divert.html.erb", :status => 404 and return
      end
      render "#{controller}/divert.html.erb", :status => 404 and return
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
