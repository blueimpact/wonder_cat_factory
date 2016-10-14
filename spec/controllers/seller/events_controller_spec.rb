require 'rails_helper'

RSpec.describe Seller::EventsController, type: :controller do
  login_seller

  describe 'GET #index' do
    let(:product) {
      FactoryGirl.create(:product, :started, user: @current_user)
    }

    let(:bid) { FactoryGirl.create(:bid, product: product) }

    let!(:events) {
      FactoryGirl.create_list(:bid, 2, product: product)
      [
        Events::StartedEvent.find_by(product: product),
        *Events::EnqueuedEvent.where(product: product).to_a
      ]
    }

    it 'assings events for product' do
      get :index, { product_id: product.id }
      expect(assigns(:events)).to eq events
    end

    it 'assings events for bid' do
      events = [
        Events::StartedEvent.find_by(product: product),
        Events::EnqueuedEvent.find_by(bid: bid)
      ]
      get :index, { product_id: product.id, bid_id: bid.id }
      expect(assigns(:events)).to eq events
    end
  end
end
