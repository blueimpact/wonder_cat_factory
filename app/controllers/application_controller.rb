class ApplicationController < ActionController::Base
  include AsAdmin

  protect_from_forgery with: :exception

  %w(admin seller).each do |role|
    define_method "authenticate_#{role}!" do
      unless current_user && current_user.send("#{role}?")
        redirect_back_or :root, alert: I18n.t('messages.not_authorized')
        false
      end
    end
  end

  def redirect_back_or path, *args
    redirect_to(request.referer || path, *args)
  end
end
