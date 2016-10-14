require 'rails_helper'

RSpec.describe Admin::BidsController, type: :controller do
  login_admin

  let(:product) { FactoryGirl.create(:product) }

  describe 'GET #index' do
    it 'assigns bids' do
      bids = FactoryGirl.create_list(:bid, 2, product: product)
      get :index, { product_id: product.id }
      expect(assigns(:bids)).to eq bids
    end
  end

  describe 'GET #show' do
    let(:product) { FactoryGirl.create(:product, :started) }

    let!(:bid) { FactoryGirl.create(:bid, product: product) }

    it 'assigns bid' do
      get :show, { product_id: product.id, id: bid.id }
      expect(assigns(:bid)).to eq bid
    end

    it 'assings events for bid' do
      FactoryGirl.create_list(:bid, 2, product: product)
      events = [
        Events::StartedEvent.find_by(product: product),
        Events::EnqueuedEvent.find_by(bid: bid)
      ]
      get :show, { product_id: product.id, id: bid.id }
      expect(assigns(:events)).to eq events
    end
  end
end
