require 'rails_helper'

RSpec.describe Seller::BidsController, type: :controller do
  login_seller

  describe 'GET #index' do
    it 'fails to access if product user is not current_user' do
      product = FactoryGirl.create(:product)
      expect {
        get :index, { product_id: product.id }
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'GET #show' do
    it 'fails to access if product user is not current_user' do
      product = FactoryGirl.create(:product)
      bid = FactoryGirl.create(:bid, product: product)
      expect {
        get :show, { product_id: product.id, id: bid.id }
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
