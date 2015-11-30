require 'rails_helper'

RSpec.describe Seller::ProductsController, type: :controller do
  login_seller

  describe 'GET #index' do
    it 'assigns products of current_user as @products' do
      products = FactoryGirl.create_list(:product, 2, user: @current_user)
      FactoryGirl.create(:product)
      get :index, {}
      expect(assigns(:products)).to eq products.reverse
    end
  end
end
