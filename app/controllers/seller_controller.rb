class SellerController < ApplicationController
  before_action :authenticate_seller!
end
