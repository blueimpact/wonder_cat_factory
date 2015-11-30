require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  login_seller

  let(:valid_attributes) {
    { body: 'Comment Body.' }
  }

  let(:invalid_attributes) {
    { body: nil }
  }

  before do
    @product = FactoryGirl.create(:product, user: @current_user)
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Comment' do
        expect {
          post :create, { product_id: @product.id, comment: valid_attributes }
        }.to change(Comment, :count).by(1)
      end

      it 'assigns a newly created comment as @comment' do
        post :create, { product_id: @product.id, comment: valid_attributes }
        expect(assigns(:comment)).to be_a(Comment)
        expect(assigns(:comment)).to be_persisted
      end

      it 'redirects to the product' do
        post :create, { product_id: @product.id, comment: valid_attributes }
        expect(response).to redirect_to(@product)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved comment as @comment' do
        post :create, { product_id: @product.id, comment: invalid_attributes }
        expect(assigns(:comment)).to be_a_new(Comment)
      end

      it 'redirects to the product' do
        post :create, { product_id: @product.id, comment: invalid_attributes }
        expect(response).to redirect_to(@product)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested comment' do
      comment = FactoryGirl.create(:comment, :with_product)
      expect {
        delete :destroy, { product_id: @product.id, id: comment.id }
      }.to change(Comment, :count).by(-1)
    end

    it 'redirects to the product' do
      comment = FactoryGirl.create(:comment, :with_product)
      delete :destroy, { product_id: @product.id, id: comment.id }
      expect(response).to redirect_to(@product)
    end
  end
end
