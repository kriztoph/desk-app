class DeskTemplatesController < ApplicationController
  def find
    render template_path, layout: false
  end

  def template_path
    "/app/assets/javascripts/" + params[:template_path]
  end
end
