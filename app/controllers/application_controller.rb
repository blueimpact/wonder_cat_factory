class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  %w(admin seller).each do |role|
    define_method "authenticate_#{role}!" do
      unless current_user && current_user.send("#{role}?")
        redirect_back_or :root, alert: "This page is for #{role} only."
        false
      end
    end
  end
end
