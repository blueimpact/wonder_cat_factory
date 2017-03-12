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
end
