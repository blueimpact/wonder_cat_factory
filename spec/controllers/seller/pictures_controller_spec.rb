require 'rails_helper'

RSpec.describe Seller::PicturesController, type: :controller do
  login_seller

  let(:valid_attributes) {
    file = Rails.root.join('spec/fixtures/image.jpg')
    { image: Rack::Test::UploadedFile.new(file) }
  }

  let(:invalid_attributes) {
    { image: nil }
  }

  before do
    @product = FactoryGirl.create(:product, user: @current_user)
  end

  describe 'POST #create' do
    it 'creates picture' do
      expect {
        post :create, { product_id: @product.id, picture: valid_attributes }
      }.to change(Picture, :count).by(1)
    end

    it 'fails without image' do
      expect {
        post :create, { product_id: @product.id, picture: invalid_attributes }
      }.not_to change(Picture, :count)
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys picture' do
      picture = FactoryGirl.create(:picture, product: @product)

      expect {
        delete :destroy, { product_id: @product.id, id: picture.id }
      }.to change(Picture, :count).by(-1)
    end
  end
end
