require 'rails_helper'

RSpec.describe BidsController, type: :controller do
  let(:product) { FactoryGirl.create(:product, user: @current_user) }

  describe 'as a user' do
    login_user

    describe "GET #index" do
      it "fails to access" do
        expect {
          get :index, { product_id: product.id }
        }.to raise_error(CanCan::AccessDenied)
      end
    end

    describe "POST #create" do
      it "creates bid" do
        expect {
          xhr :post, :create, { product_id: product.id }
        }.to change(Bid, :count).by(1)

        product.reload
        expect(product.bids_count).to eq 1
      end
    end

    describe "DELETE #destroy" do
      it "destroys bid" do
        FactoryGirl.create(:bid, user: @current_user, product: product)
        expect {
          xhr :delete, :destroy, { product_id: product.id }
        }.to change(Bid, :count).by(-1)
      end
    end
  end

  describe 'as a seller' do
    login_seller

    describe "GET #index" do
      it "assigns bids" do
        bids = FactoryGirl.create_list(:bid, 2, :with_user, product: product)
        get :index, { product_id: product.id }

        expect(assigns(:bids)).to eq bids.reverse
      end

      it "fails to access if product seller is not current_user" do
        product = FactoryGirl.create(:product, :with_user)
        expect {
          get :index, { product_id: product.id }
        }.to raise_error(CanCan::AccessDenied)
      end
    end
  end

  describe 'as a admin' do
    login_admin

    describe "GET #index" do
      it "assigns bids" do
        product = FactoryGirl.create(:product, :with_user)
        bids = FactoryGirl.create_list(:bid, 2, :with_user, product: product)
        get :index, { product_id: product.id }

        expect(assigns(:bids)).to eq bids.reverse
      end
    end
  end
end
