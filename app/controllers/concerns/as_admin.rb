module AsAdmin
  extend ActiveSupport::Concern

  included do
    helper_method :as_admin?
  end

  def set_as_admin
    session[:as_admin] = true
  end

  def reset_as_admin
    session.delete :as_admin
  end

  def as_admin?
    session.fetch :as_admin, false
  end
end
