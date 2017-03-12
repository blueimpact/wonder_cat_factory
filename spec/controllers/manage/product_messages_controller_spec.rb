require 'rails_helper'

shared_examples_for Manage::ProductMessagesController do
  let(:invalid_attributes) { { subject: nil } }

  describe 'GET #index' do
    it "assigns product's product_messages as @product_messages" do
      get :index, { product_id: product.id }
      expect(assigns(:product_messages)).to eq(product.product_messages)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested product_message as @product_message' do
      product_message = product.product_messages.first
      get :edit, { product_id: product.id, id: product_message.id }
      expect(assigns(:product_message)).to eq(product_message)
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
        product_message = product.product_messages.first
        put :update, {
          id: product_message.to_param,
          product_id: product.id,
          product_message: new_attributes
        }
        product_message.reload
        expect(product_message.subject).to eq 'New subject'
      end

      it 'assigns the requested product_message as @product_message' do
        product_message = product.product_messages.first
        put :update, {
          id: product_message.to_param,
          product_id: product.id,
          product_message: new_attributes
        }
        expect(assigns(:product_message)).to eq(product_message)
      end

      it 'redirects to the product_messages list' do
        product_message = product.product_messages.first
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
        product_message = product.product_messages.first
        put :update, {
          id: product_message.to_param,
          product_id: product.id,
          product_message: invalid_attributes
        }
        expect(assigns(:product_message)).to eq(product_message)
      end

      it "re-renders the 'edit' template" do
        product_message = product.product_messages.first
        put :update, {
          id: product_message.to_param,
          product_id: product.id,
          product_message: invalid_attributes
        }
        expect(response).to render_template(:edit)
      end
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
