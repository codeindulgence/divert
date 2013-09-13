require "divert/engine"

module Divert
  def action_missing path = nil
    path ||= params[:path]
    if action_methods.include? path
      send path and return
    end

    if template_exists?(path, [controller_name])
      render "#{controller_name}/#{path}" and return
    end

    if (redirect = Redirect.hit request.fullpath)
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
    match ":action" => "static"
    match '*path' => "#{controller}#action_missing", :format => false
  end
end
