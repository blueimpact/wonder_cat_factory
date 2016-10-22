require 'rails_helper'

shared_examples_for Manage::BidsController do
  describe 'GET #index' do
    it 'assigns bids' do
      bids = FactoryGirl.create_list(:bid, 2, product: product)
      get :index, { product_id: product.id }
      expect(assigns(:bids)).to eq bids
    end
  end

  describe 'GET #show' do
    let(:bid) { FactoryGirl.create(:bid, product: product) }

    it 'assigns bid' do
      get :show, { product_id: product.id, id: bid.id }
      expect(assigns(:bid)).to eq bid
    end

    it 'assings events for bid' do
      product.pictures = [FactoryGirl.create(:picture)]
      product.update started_at: Time.current
      events = [
        Events::StartedEvent.find_by(product: product),
        Events::EnqueuedEvent.find_by(bid: bid)
      ]
      FactoryGirl.create_list(:bid, 2, product: product)
      get :show, { product_id: product.id, id: bid.id }
      expect(assigns(:events)).to eq events
    end
  end
end

RSpec.describe Admin::BidsController, type: :controller do
  login_admin
  let(:role) { :admin }
  let(:product) { FactoryGirl.create(:product) }
  it_behaves_like Manage::BidsController
end

RSpec.describe Seller::BidsController, type: :controller do
  login_seller
  let(:role) { :seller }
  let(:product) { FactoryGirl.create(:product, user: @current_user) }
  it_behaves_like Manage::BidsController
end
