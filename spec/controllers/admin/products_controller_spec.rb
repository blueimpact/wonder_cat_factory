require 'rails_helper'

RSpec.describe Admin::ProductsController, type: :controller do
  login_admin

  let(:valid_attributes) {
    {
      title: 'Product',
      price: 1000,
      goal: 10
    }
  }

  let(:invalid_attributes) { { title: nil }}

  describe "GET #index" do
    it "assigns all products as @products" do
      products = [
        *FactoryGirl.create_list(:product, 2, user: @current_user),
        FactoryGirl.create(:product, :with_user)
      ]
      get :index, {}
      expect(assigns(:products)).to eq products
    end
  end

  describe "GET #edit" do
    it "assigns the requested product as @product" do
      product = Product.create! valid_attributes
      get :edit, {:id => product.to_param}
      expect(assigns(:product)).to eq(product)
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          title: 'New Title'
        }
      }

      it "updates the requested product" do
        product = Product.create! valid_attributes
        put :update, {:id => product.to_param, :product => new_attributes}
        product.reload
        expect(product.title).to eq 'New Title'
      end

      it "assigns the requested product as @product" do
        product = Product.create! valid_attributes
        put :update, {:id => product.to_param, :product => valid_attributes}
        expect(assigns(:product)).to eq(product)
      end

      it "redirects to the product" do
        product = Product.create! valid_attributes
        put :update, {:id => product.to_param, :product => valid_attributes}
        expect(response).to redirect_to([:edit, :seller, product])
      end
    end

    context "with invalid params" do
      it "assigns the product as @product" do
        product = Product.create! valid_attributes
        put :update, {:id => product.to_param, :product => invalid_attributes}
        expect(assigns(:product)).to eq(product)
      end

      it "re-renders the 'edit' template" do
        product = Product.create! valid_attributes
        put :update, {:id => product.to_param, :product => invalid_attributes}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested product" do
      product = Product.create! valid_attributes
      expect {
        delete :destroy, {:id => product.to_param}
      }.to change(Product, :count).by(-1)
    end

    it "redirects to the products list" do
      product = Product.create! valid_attributes
      delete :destroy, {:id => product.to_param}
      expect(response).to redirect_to(seller_products_url)
    end
  end
end
