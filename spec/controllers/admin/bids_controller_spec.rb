require 'rails_helper'

RSpec.describe Admin::BidsController, type: :controller do
  login_admin

  describe 'GET #index' do
    it 'assigns bids' do
      product = FactoryGirl.create(:product)
      bids = FactoryGirl.create_list(:bid, 2, product: product)
      get :index, { product_id: product.id }

      expect(assigns(:bids)).to eq bids.reverse
    end
  end
end
