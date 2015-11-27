require 'rails_helper'

RSpec.describe BidsController, type: :controller do
  login_user

  before do
    @product = FactoryGirl.create(:product, user: @current_user)
  end
  

  describe "GET #index" do
    it "assigns bids" do
      bids = FactoryGirl.create_list(:bid, 2, :with_user, product: @product)
      get :index, { product_id: @product.id }

      expect(assigns(:bids)).to eq bids.reverse
    end
  end

  describe "POST #create" do
    it "creates bid" do
      expect {
        xhr :post, :create, { product_id: @product.id }
      }.to change(Bid, :count).by(1)

      @product.reload
      expect(@product.bids_count).to eq 1
    end
  end

  describe "DELETE #destroy" do
    it "destroys bid" do
      FactoryGirl.create(:bid, user: @current_user, product: @product)
      expect {
        xhr :delete, :destroy, { product_id: @product.id }
      }.to change(Bid, :count).by(-1)
    end
  end
end
