require 'rails_helper'

shared_examples_for Manage::ProductMessagesController do
  let(:invalid_attributes) { { subject: nil } }

  let(:valid_attributes) {
    {
      message_type: :enqueued_event,
      subject: 'Subject Subject Subject',
      body: 'Body Body Body'
    }
  }

  let(:invalid_attributes) { { subject: nil } }

  describe 'GET #index' do
    it "assigns product's product_messages as @product_messages" do
      product_messages = FactoryGirl.create_list(
        :product_message,
        3,
        product: product
      )

      get :index, { product_id: product.id }
      expect(assigns(:product_messages)).to eq(product_messages)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested product_message as @product_message' do
      product_message = FactoryGirl.create(:product_message, product: product)
      get :edit, { id: product_message.to_param, product_id: product.id }
      expect(assigns(:product_message)).to eq(product_message)
    end

    it 'assigns non-used message_type as @selectable_message_types' do
      product_message = FactoryGirl.create(
        :product_message, product: product, message_type: :enqueued_event
      )
      FactoryGirl.create(
        :product_message, product: product, message_type: :goaled_event
      )

      get :edit, { id: product_message.to_param, product_id: product.id }
      expect(assigns(:selectable_message_types)).to eq(
        { 'enqueued_event' => 1, 'dequeued_event' => 3 }
      )
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new ProductMessage' do
        expect {
          post :create, {
            product_message: valid_attributes, product_id: product.id
          }
        }.to change(ProductMessage, :count).by(1)
      end

      it 'assigns a newly created product_message as @product_message' do
        post :create, {
          product_message: valid_attributes, product_id: product.id
        }
        expect(assigns(:product_message)).to be_a(ProductMessage)
        expect(assigns(:product_message)).to be_persisted
      end

      it 'redirects to the product_messages list' do
        post :create, {
          product_message: valid_attributes, product_id: product.id
        }
        expect(response).to redirect_to([role, product, :product_messages])
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved user as @product_message' do
        post :create, {
          product_message: invalid_attributes, product_id: product.id
        }
        expect(assigns(:product_message)).to be_a_new(ProductMessage)
      end

      it "re-renders the 'new' template" do
        post :create, {
          product_message: invalid_attributes, product_id: product.id
        }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) {
        {
          subject: 'New subject'
        }
      }

      it 'updates the requested product_message' do
        product_message = FactoryGirl.create(:product_message, product: product)

        put :update, {
          id: product_message.to_param,
          product_id: product.id,
          product_message: new_attributes
        }
        product_message.reload
        expect(product_message.subject).to eq 'New subject'
      end

      it 'assigns the requested product_message as @product_message' do
        product_message = FactoryGirl.create(:product_message, product: product)
        put :update, {
          id: product_message.to_param,
          product_id: product.id,
          product_message: new_attributes
        }
        expect(assigns(:product_message)).to eq(product_message)
      end

      it 'redirects to the product_messages list' do
        product_message = FactoryGirl.create(:product_message, product: product)
        put :update, {
          id: product_message.to_param,
          product_id: product.id,
          product_message: new_attributes
        }
        expect(response).to redirect_to([role, product, :product_messages])
      end
    end

    context 'with invalid params' do
      it 'assigns the product_message as @product_message' do
        product_message = FactoryGirl.create(:product_message, product: product)
        put :update, {
          id: product_message.to_param,
          product_id: product.id,
          product_message: invalid_attributes
        }
        expect(assigns(:product_message)).to eq(product_message)
      end

      it "re-renders the 'edit' template" do
        product_message = FactoryGirl.create(:product_message, product: product)
        put :update, {
          id: product_message.to_param,
          product_id: product.id,
          product_message: invalid_attributes
        }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested product message' do
      product_message = FactoryGirl.create(:product_message, product: product)
      expect {
        delete :destroy, {
          id: product_message.to_param, product_id: product.id
        }
      }.to change(ProductMessage, :count).by(-1)
    end

    it 'redirects to the product_message list' do
      product_message = FactoryGirl.create(:product_message, product: product)
      delete :destroy, {
        id: product_message.to_param, product_id: product.id
      }
      expect(response).to redirect_to([role, product, :product_messages])
    end
  end
end

RSpec.describe Admin::ProductMessagesController, type: :controller do
  login_admin
  let(:role) { :admin }
  let(:product) { FactoryGirl.create(:product) }
  it_behaves_like Manage::ProductMessagesController
end

RSpec.describe Seller::ProductMessagesController, type: :controller do
  login_seller
  let(:role) { :seller }
  let(:product) { FactoryGirl.create(:product, user: @current_user) }
  it_behaves_like Manage::ProductMessagesController
end
