require "divert/engine"

module Divert
  def divert
    if template_exists?(params[:path], [controller_name])
        render "#{controller_name}/#{params[:path]}" and return
    end

    if action_methods.include? params[:path]
      send params[:path] and return
    end

    if (redirect = Redirect.hit request.fullpath)
      redirect_to redirect
    else
      unless template_exists? 'divert', [controller_name]
        render text:"Missing divert view: #{controller_name}/divert.html.erb" and return
      end
    end
  end
end

class ActionDispatch::Routing::Mapper
  def divert_with controller
    match '*path' => "#{controller}#divert", :format => false
  end
end
