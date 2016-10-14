require 'rails_helper'

RSpec.describe Seller::EventsController, type: :controller do
  login_seller

  describe 'GET #index' do
    it 'fails to access if product user is not current_user' do
      product = FactoryGirl.create(:product)
      expect {
        get :index, { product_id: product.id }
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
