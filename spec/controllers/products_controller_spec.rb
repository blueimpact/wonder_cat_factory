require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe 'as a guest' do
    describe "GET #index" do
      it "assigns ready products as @products" do
        products = FactoryGirl.create_list(:product, 2, :with_user, :with_one_picture)
        FactoryGirl.create(:product, :with_user)
        FactoryGirl.create(:product, :with_user, :with_one_picture, closes_on: 1.week.ago)

        get :index
        expect(assigns(:products).to_a).to eq products
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

  describe 'as a user' do
    login_user

    describe "GET #bidden" do
      it 'filters by bidden' do
        products = FactoryGirl.create_list(:product, 2, :with_user, :with_one_picture)
        products.each do |product|
          @current_user.bid product
        end
        FactoryGirl.create(:product, :with_user, :with_one_picture)

        get :bidden
        expect(assigns(:products).to_a).to eq products
      end
    end
  end

  describe 'as a seller' do
    login_seller

    let(:invalid_attributes) { { title: nil }}

    describe "GET #new" do
      it "assigns a new product as @product" do
        get :new
        expect(assigns(:product)).to be_a_new(Product)
      end
    end

    describe "GET #edit" do
      it "assigns the requested product as @product" do
        product = FactoryGirl.create(:product, user: @current_user)
        get :edit, {:id => product.to_param}
        expect(assigns(:product)).to eq(product)
      end
    end

    describe "POST #create" do
      context "with valid params" do
        let(:valid_attributes) {
          {
            title: 'Product',
            price: 1000,
            goal: 10
          }
        }

        it "creates a new Product" do
          expect {
            post :create, {:product => valid_attributes}
          }.to change(Product, :count).by(1)
        end

        it "assigns a newly created product as @product" do
          post :create, {:product => valid_attributes}
          expect(assigns(:product)).to be_a(Product)
          expect(assigns(:product)).to be_persisted
        end

        it "sets user as current_user" do
          post :create, {:product => valid_attributes}
          product = assigns(:product)
          expect(product.user).to eq @current_user
        end

        it "redirects to the created product" do
          post :create, {:product => valid_attributes}
          expect(response).to redirect_to([:edit, Product.last])
        end
      end

      context "with invalid params" do
        it "assigns a newly created but unsaved product as @product" do
          post :create, {:product => invalid_attributes}
          expect(assigns(:product)).to be_a_new(Product)
        end

        it "re-renders the 'new' template" do
          post :create, {:product => invalid_attributes}
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT #update" do
      let(:product) { FactoryGirl.create(:product, user: @current_user) }

      context "with valid params" do
        let(:new_attributes) {
          {
            title: 'New Title'
          }
        }

        it "updates the requested product" do
          put :update, {:id => product.to_param, :product => new_attributes}
          product.reload
          expect(product.title).to eq 'New Title'
        end

        it "assigns the requested product as @product" do
          put :update, {:id => product.to_param, :product => new_attributes}
          expect(assigns(:product)).to eq(product)
        end

        it "redirects to the product" do
          put :update, {:id => product.to_param, :product => new_attributes}
          expect(response).to redirect_to([:edit, product])
        end
      end

      context "with invalid params" do
        it "assigns the product as @product" do
          put :update, {:id => product.to_param, :product => invalid_attributes}
          expect(assigns(:product)).to eq(product)
        end

        it "re-renders the 'edit' template" do
          put :update, {:id => product.to_param, :product => invalid_attributes}
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE #destroy" do
      let(:product) { FactoryGirl.create(:product, user: @current_user) }

      it "destroys the requested product" do
        product
        expect {
          delete :destroy, {:id => product.to_param}
        }.to change(Product, :count).by(-1)
      end

      it "redirects to the products list" do
        delete :destroy, {:id => product.to_param}
        expect(response).to redirect_to(products_url)
      end
    end
  end
end
