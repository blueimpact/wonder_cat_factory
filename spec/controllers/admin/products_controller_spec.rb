require 'rails_helper'

RSpec.describe Admin::ProductsController, type: :controller do
  login_admin

  describe 'GET #index' do
    it 'assigns all products as @products' do
      products = FactoryGirl.create_list(:product, 2)
      get :index, {}
      expect(assigns(:products)).to eq products.reverse
    end

    it 'assigns products of given user as @products' do
      user = FactoryGirl.create(:user)
      products = FactoryGirl.create_list(:product, 2, user: user)
      FactoryGirl.create(:product)
      get :index, { user_id: user.id }
      expect(assigns(:products)).to eq products.reverse
    end
  end

  describe 'GET #show' do
    let(:product) { FactoryGirl.create(:product, :started) }

    let!(:bids) { FactoryGirl.create_list(:bid, 2, product: product) }

    it 'assings events for product' do
      get :show, { id: product.id }
      expect(assigns(:events).count).to eq 3
      expect(assigns(:events)).to eq product.events
    end
  end
end
