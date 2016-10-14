require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  login_user

  let(:product) { FactoryGirl.create(:product, :started) }

  describe 'GET #index' do
    let!(:bid) { product.bids.create(user: @current_user) }

    it 'assings bid by current_user as @bid' do
      get :index, { product_id: product.id }
      expect(assigns(:bid)).to eq bid
    end

    it 'assings events for current_user as @events' do
      FactoryGirl.create_list(:bid, 2, product: product)
      product.update goaled_at: Time.current
      events = [
        Events::StartedEvent.find_by(product: product),
        Events::EnqueuedEvent.find_by(bid: bid),
        Events::GoaledEvent.find_by(product: product)
      ]
      get :index, { product_id: product.id }
      expect(assigns(:events)).to eq events
    end
  end
end
