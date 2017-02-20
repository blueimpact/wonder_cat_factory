require 'rails_helper'

RSpec.describe Product, type: :model do
  describe '#create_charge' do
    let(:stripe_customer_id) { 'cus_xxxxxxxxxxxxxx' }

    before do
      allow(Settings.stripe).to receive(:fee_percentage) { 0.1 }
    end

    context 'with user has stripe_account' do
      let(:user) { FactoryGirl.create(:user, :with_stripe_account) }
      let(:product) { FactoryGirl.create(:product, user: user) }

      it 'returns Stripe::Charge Object' do
        result = product.create_charge stripe_customer_id
        expect(result.class).to eq Stripe::Charge
      end
    end

    context 'with user has not stripe_account' do
      let(:user) { FactoryGirl.create(:user) }
      let(:product) { FactoryGirl.create(:product, user: user) }

      it 'raises error' do
        expect { product.create_charge @stripe_customer_id }.to raise_error(
          RuntimeError, 'Seller account must need stripe account.'
        )
      end
    end
  end
end
