require 'rails_helper'

RSpec.describe Seller::BidsController, type: :controller do
  login_seller

  describe 'GET #index' do
    let(:product) { FactoryGirl.create(:product, user: @current_user) }

    it 'assigns bids' do
      bids = FactoryGirl.create_list(:bid, 2, product: product)
      get :index, { product_id: product.id }

      expect(assigns(:bids)).to eq bids
    end

    it 'fails to access if product seller is not current_user' do
      product = FactoryGirl.create(:product)
      expect {
        get :index, { product_id: product.id }
      }.to raise_error(CanCan::AccessDenied)
    end
  end
end
