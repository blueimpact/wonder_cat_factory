require 'rails_helper'

RSpec.describe Seller::EventsController, type: :controller do
  login_seller

  describe 'GET #index' do
    let(:product) { FactoryGirl.create(:product) }

    it 'returns http success' do
      get :index, { product_id: product }
      expect(response).to have_http_status(:success)
    end
  end
end
