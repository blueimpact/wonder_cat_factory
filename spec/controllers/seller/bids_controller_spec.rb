require 'rails_helper'

RSpec.describe Seller::BidsController, type: :controller do
  login_seller

  let(:product) { FactoryGirl.create(:product, user: @current_user) }

  describe 'GET #index' do
    it 'assigns bids' do
      bids = FactoryGirl.create_list(:bid, 2, product: product)
      get :index, { product_id: product.id }
      expect(assigns(:bids)).to eq bids
    end

    context 'with product by another seller' do
      let(:product) { FactoryGirl.create(:product) }

      it 'fails to access if product seller is not current_user' do
        product = FactoryGirl.create(:product)
        expect {
          get :index, { product_id: product.id }
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'GET #show' do
    let(:bid) { FactoryGirl.create(:bid, product: product) }

    let(:bids) { [bid, *FactoryGirl.create_list(:bid, 2, product: product)] }

    it 'assigns bid' do
      get :show, { product_id: product.id, id: bid.id }
      expect(assigns(:bid)).to eq bid
    end

    it 'assings events for bid' do
      events = [
        FactoryGirl.create(:started_event, product: product),
        *bids.map { |bid|
          FactoryGirl.create(:enqueued_event, product: product, bid: bid)
        }
      ]
      get :show, { product_id: product.id, id: bid.id }
      expect(assigns(:events)).to eq events.take(2)
    end

    context 'with product by another seller' do
      let(:product) { FactoryGirl.create(:product) }

      it 'fails to access if product seller is not current_user' do
        expect {
          get :show, { product_id: product.id, id: bid.id }
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
