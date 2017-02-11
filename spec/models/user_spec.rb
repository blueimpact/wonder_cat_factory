require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#bidded?' do
    before do
      @user = FactoryGirl.create(:user)
      @product = FactoryGirl.create(:product)
    end

    it 'return false if not bidded' do
      expect(@user.bidded?(@product)).to eq false
    end

    it 'return true if bidded' do
      @user.bids.create(product: @product)
      expect(@user.bidded?(@product)).to eq true
    end
  end

  describe '#attach_srtripe_account!' do
    before do
      @user = FactoryGirl.create(:user)
    end

    it "creates user's stripe_account" do
      @user.attach_stripe_account!
      expect(@user.stripe_account).to be_persisted
    end
  end

  describe '#update_purchased' do
    before do
      @user = FactoryGirl.create(:user)
      @product = FactoryGirl.create(:product)
      @user.bids.create(product: @product)
      @time_current = Time.zone.local(2017, 1, 30, 15, 0, 0)
      allow(Time).to receive_message_chain(:current).and_return(@time_current)
    end

    it "sets current time to paid_at of user's bids" do
      @user.update_purchased @product
      expect(@user.bids.first.paid_at).to eq @time_current

  describe '#create' do
    context 'create seller' do
      it 'creates 3 system messages' do
        expect {
          FactoryGirl.create(:user, :seller)
        }.to change(SystemMessage, :count).by(3)
      end

      it 'creates 3 type system messages' do
        @user = FactoryGirl.create(:user, :seller)
        expect(@user.system_messages.started.first).to be_persisted
        expect(@user.system_messages.enqueued.first).to be_persisted
        expect(@user.system_messages.goaled.first).to be_persisted
      end
    end

    context 'create user' do
      it 'does not create system message' do
        expect {
          FactoryGirl.create(:user)
        }.to change(SystemMessage, :count).by(0)
      end
    end
  end

  describe '#update' do
    context 'update to be a seller' do
      before do
        @user = FactoryGirl.create(:user)
      end

      it 'creates 3 system messages' do
        expect {
          @user.update(is_seller: true)
        }.to change(SystemMessage, :count).by(3)
      end

      it 'creates 3 type system messages' do
        @user.update(is_seller: true)
        expect(@user.system_messages.started.first).to be_persisted
        expect(@user.system_messages.enqueued.first).to be_persisted
        expect(@user.system_messages.goaled.first).to be_persisted
      end
    end
  end
end
