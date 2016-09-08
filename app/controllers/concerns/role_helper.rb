module RoleHelper
  extend ActiveSupport::Concern

  ROLES = %i(admin seller).freeze

  included do
    ROLES.each do |role|
      define_method "authenticate_#{role}!" do
        unless current_user && current_user.send("#{role}?")
          redirect_back_or :root, alert: I18n.t('messages.not_authorized')
          false
        end
      end

      define_method "as_#{role}?" do
        current_role == role
      end

      helper_method "as_#{role}?"
    end

    helper_method :current_role
  end

  def current_role
    nil
  end
end
