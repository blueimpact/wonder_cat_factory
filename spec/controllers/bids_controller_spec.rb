require 'rails_helper'

RSpec.describe BidsController, type: :controller do
  login_user

  let(:product) { FactoryGirl.create(:product, user: @current_user) }

  describe 'GET #index' do
    it 'assings bids of current_user as @bids' do
      products = FactoryGirl.create_list(:product, 2, :with_one_picture)
      products.each do |product|
        @current_user.bid product
      end
      FactoryGirl.create(:product, :with_one_picture)

      get :index
      expect(assigns(:bids).to_a).to eq @current_user.bids.newer_first
    end
  end

  describe 'GET #show' do
    let(:product) {
      FactoryGirl.create(:product, :started, user: @current_user)
    }

    let!(:bid) { product.bids.create(user: @current_user) }

    it 'assings bid by current_user as @bid' do
      get :show, { product_id: product.id }
      expect(assigns(:bid)).to eq bid
    end

    it 'assings events for current_user as @events' do
      FactoryGirl.create_list(:bid, 2, product: product)
      events = [
        Events::StartedEvent.find_by(product: product),
        Events::EnqueuedEvent.find_by(bid: bid)
      ]
      get :show, { product_id: product.id }
      expect(assigns(:events)).to eq events
    end
  end

  describe 'POST #create' do
    it 'creates bid' do
      expect {
        xhr :post, :create, { product_id: product.id }
      }.to change(Bid, :count).by(1)

      product.reload
      expect(product.bids_count).to eq 1
    end

    it 'creates EnqueuedEvent' do
      expect {
        xhr :post, :create, { product_id: product.id }
      }.to change(Events::EnqueuedEvent, :count).by(1)

      event = Events::EnqueuedEvent.last
      expect(event.bid.product_id).to eq product.id
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys bid' do
      FactoryGirl.create(:bid, user: @current_user, product: product)
      expect {
        xhr :delete, :destroy, { product_id: product.id }
      }.to change(Bid, :count).by(-1)
    end
  end
end
