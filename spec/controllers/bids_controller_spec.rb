require 'rails_helper'

RSpec.describe BidsController, type: :controller do
  login_user

  let(:seller) { FactoryGirl.create(:user, :seller, :with_stripe_account) }
  let(:seller_not_have_stripe_account) { FactoryGirl.create(:user, :seller) }

  let(:product) { FactoryGirl.create(:product, user: seller) }
  let(:product_not_have_stripe_account) {
    FactoryGirl.create(:product, user: seller_not_have_stripe_account)
  }

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

    it 'redirects to the user page' do
      FactoryGirl.create(:bid, user: @current_user, product: product)
      xhr :delete, :destroy, { product_id: product.id }
      expect(response).to redirect_to(product_url(product))
    end

    it 'cannot destroy paid bid' do
      FactoryGirl.create(
        :bid,
        user: @current_user,
        product: product,
        paid_at: Time.current
      )
      expect {
        xhr :delete, :destroy, { product_id: product.id }
      }.not_to change(Bid, :count)
    end
  end

  describe 'POST #charge' do
    before(:each) do
      request.env['HTTP_REFERER'] = product_url(product)
      allow(Settings.stripe).to receive(:fee_percentage) { 0.1 }
    end

    context 'with user does not bid' do
      it 'redirects to back' do
        post :charge, { product_id: product.id }
        expect(response).to redirect_to(product_url(product))
      end
    end

    context 'with user already charged' do
      it 'redirects to back' do
        FactoryGirl.create(
          :bid, user: @current_user, product: product, paid_at: Time.current
        )
        post :charge, { product_id: product.id }
        expect(response).to redirect_to(product_url(product))
      end
    end

    context 'with user bid and not charged' do
      it 'raises error when seller does not have stripe account' do
        FactoryGirl.create(
          :bid, user: @current_user, product: product_not_have_stripe_account
        )
        expect {
          post :charge, { product_id: product_not_have_stripe_account.id }
        }.to raise_error(
          RuntimeError, 'Seller account must need stripe account.'
        )
      end

      it 'updates paid_at to current time' do
        time_current = Time.zone.local(2017, 1, 30, 15, 0, 0)
        allow(Time).to receive_message_chain(:current).and_return(time_current)
        bid = FactoryGirl.create(
          :bid, user: @current_user, product: product
        )
        post :charge, { product_id: product.id }
        bid.reload
        expect(bid.paid_at).to eq time_current
      end
    end
  end
end
