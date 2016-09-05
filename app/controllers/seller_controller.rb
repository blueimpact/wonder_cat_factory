class SellerController < ApplicationController
  before_action :authenticate_seller!
  before_action :reset_as_admin
end
