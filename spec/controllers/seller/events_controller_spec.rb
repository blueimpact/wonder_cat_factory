require 'rails_helper'

RSpec.describe Seller::EventsController, type: :controller do
  login_seller

  describe 'GET #index' do
    let(:product) { FactoryGirl.create(:product, user: @current_user) }

    let(:bid) { FactoryGirl.create(:bid, product: product) }

    let(:bids) { [bid, *FactoryGirl.create_list(:bid, 2, product: product)] }

    let!(:events) {
      [
        FactoryGirl.create(:started_event, product: product),
        *bids.map { |bid|
          FactoryGirl.create(:enqueued_event, product: product, bid: bid)
        }
      ]
    }

    it 'assings events for product' do
      get :index, { product_id: product.id }
      expect(assigns(:events)).to eq events
    end

    it 'assings events for bid' do
      get :index, { product_id: product.id, bid_id: bid.id }
      expect(assigns(:events)).to eq events.take(2)
    end
  end
end
