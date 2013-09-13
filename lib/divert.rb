require "divert/engine"

module Divert
  def action_missing path
    path ||= params[:path]
    if action_methods.include? path
      puts "SENDING METHOD: #{path}"
      send path and return
    end

    if template_exists?(path, [controller_name])
      puts "RENDERING METHOD: #{path}"
      render "#{controller_name}/#{path}" and return
    end

    if (redirect = Redirect.hit request.fullpath)
      redirect_to redirect
    else
      unless template_exists? 'divert', [controller_name]
        render text:"Missing divert view: #{controller_name}/divert.html.erb" and return
      end
      render "#{controller_name}/divert" and return
    end
  end
end

class ActionDispatch::Routing::Mapper
  def divert_with controller
    match ":action" => "static"
    match '*path' => "#{controller}#action_missing", :format => false
  end
end
