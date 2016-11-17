require 'rails_helper'

RSpec.describe Seller::PicturesController, type: :controller do
  login_seller

  let(:valid_attributes) {
    file = Rails.root.join('spec/fixtures/image.jpg')
    { image: Rack::Test::UploadedFile.new(file) }
  }

  describe 'POST #create' do
    it 'fails to access if product user is not current_user' do
      product = FactoryGirl.create(:product)
      expect {
        post :create, { product_id: product.id, picture: valid_attributes }
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'DELETE #destroy' do
    it 'fails to access if product user is not current_user' do
      product = FactoryGirl.create(:product, :with_one_picture)
      picture = product.pictures.first
      expect {
        delete :destroy, { product_id: product.id, id: picture.id }
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
