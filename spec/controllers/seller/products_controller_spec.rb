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

  describe 'GET #show' do
    it 'fails to access if product user is not current_user' do
      product = FactoryGirl.create(:product)
      expect {
        get :show, { id: product.id }
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'GET #edit' do
    it 'fails to access if product user is not current_user' do
      product = FactoryGirl.create(:product)
      expect {
        get :edit, { id: product.id }
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'PUT #update' do
    it 'fails to access if product user is not current_user' do
      product = FactoryGirl.create(:product)
      expect {
        put :update, { id: product.id }
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'DELETE #destroy' do
    it 'fails to access if product user is not current_user' do
      product = FactoryGirl.create(:product)
      expect {
        delete :destroy, { id: product.id }
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
