require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  login_user

  let(:product) { FactoryGirl.create(:product) }

  describe 'GET #index' do
    let!(:bid) { product.bids.create(user: @current_user) }

    it 'assings bid by current_user as @bid' do
      get :index, { product_id: product.id }
      expect(assigns(:bid)).to eq bid
    end

    it 'assings events for current_user as @events' do
      events = [
        FactoryGirl.create(:started_event, product: product),
        FactoryGirl.create(:enqueued_event, product: product, bid: bid)
      ]
      FactoryGirl.create(:bid, product: product).tap do |bid|
        FactoryGirl.create(:enqueued_event, product: product, bid: bid)
      end
      get :index, { product_id: product.id }
      expect(assigns(:events)).to eq events
    end
  end
end
