require 'rails_helper'

RSpec.describe Product, type: :model do
  describe '#purchased_by' do
    before do
      @product = FactoryGirl.create(:product)
      @stripe_customer_id = 'cus_xxxxxxxxxxxxxx'
      allow(Settings.stripe).to receive(:fee_percentage) { 0.1 }
    end

    context 'product with user has stripe_account' do
      before do
        @user = FactoryGirl.create(:user, :with_stripe_account)
        @product = FactoryGirl.create(:product, user: @user)
      end

      it 'return Stripe::Charge Object' do
        result = @product.purchased_by @stripe_customer_id
        expect(result.class).to eq Stripe::Charge
      end
    end

    context 'product with user has not stripe_account' do
      before do
        @user = FactoryGirl.create(:user)
        @product = FactoryGirl.create(:product, user: @user)
      end
      it 'raises error' do
        expect { @product.purchased_by @stripe_customer_id }.to raise_error(
          RuntimeError, 'Seller account must need stripe account.'
        )
      end
    end
  end
end
