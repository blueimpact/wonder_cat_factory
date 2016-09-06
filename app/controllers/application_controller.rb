class ApplicationController < ActionController::Base
  include RoleHelper

  protect_from_forgery with: :exception

  def redirect_back_or path, *args
    redirect_to(request.referer || path, *args)
  end
end
