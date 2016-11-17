require 'rails_helper'

shared_examples_for Manage::PicturesController do
  let(:valid_attributes) {
    file = Rails.root.join('spec/fixtures/image.jpg')
    { image: Rack::Test::UploadedFile.new(file) }
  }

  let(:invalid_attributes) {
    { image: nil }
  }

  describe 'POST #create' do
    it 'creates picture' do
      expect {
        xhr :post, :create,
            { product_id: product.id, picture: valid_attributes }
      }.to change(Picture, :count).by(1)
    end

    it 'fails without image' do
      expect {
        xhr :post, :create,
            { product_id: product.id, picture: invalid_attributes }
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys picture' do
      picture = FactoryGirl.create(:picture, product: product)

      expect {
        xhr :delete, :destroy,
            { product_id: product.id, id: picture.id }
      }.to change(Picture, :count).by(-1)
    end
  end
end

RSpec.describe Admin::PicturesController, type: :controller do
  login_admin
  let(:role) { :admin }
  let(:product) { FactoryGirl.create(:product) }
  it_behaves_like Manage::PicturesController
end

RSpec.describe Seller::PicturesController, type: :controller do
  login_seller
  let(:role) { :seller }
  let(:product) { FactoryGirl.create(:product, user: @current_user) }
  it_behaves_like Manage::PicturesController
end
