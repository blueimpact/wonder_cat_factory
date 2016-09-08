module AdminController
  extend ActiveSupport::Concern

  included do
    skip_before_action :authenticate_user!
    before_action :authenticate_admin!
  end

  def current_role
    :admin
  end
end
