module SellerController
  extend ActiveSupport::Concern

  included do
    skip_before_action :authenticate_user!
    before_action :authenticate_seller!
  end

  def current_role
    :seller
  end
end
