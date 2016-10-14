require 'rails_helper'

shared_examples_for Manage::EventsController do
  describe 'GET #index' do
    before do
      product.update started_at: Time.current
      FactoryGirl.create_list(:bid, 2, product: product)
    end

    let(:bid) { product.bids.first }

    it 'assings events for product' do
      events = [
        Events::StartedEvent.find_by(product: product),
        *Events::EnqueuedEvent.where(product: product).to_a
      ]
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

RSpec.describe Admin::EventsController, type: :controller do
  login_admin
  let(:role) { :admin }
  let(:product) { FactoryGirl.create(:product) }
  it_behaves_like Manage::EventsController
end

RSpec.describe Seller::EventsController, type: :controller do
  login_seller
  let(:role) { :seller }
  let(:product) { FactoryGirl.create(:product, user: @current_user) }
  it_behaves_like Manage::EventsController
end
