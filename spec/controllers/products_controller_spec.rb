require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe "GET #index" do
    it "assigns all products as @products" do
      products = FactoryGirl.create_list(:product, 2, :with_user)
      get :index, {}
      expect(assigns(:products)).to eq products
    end
  end

  describe "GET #show" do
    it "assigns the requested product as @product" do
      product = FactoryGirl.create(:product, :with_user)
      get :show, {:id => product.to_param}
      expect(assigns(:product)).to eq(product)
    end
  end
end
