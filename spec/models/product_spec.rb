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

  describe '#create' do
    context 'create product' do
      it 'creates 3 product messages' do
        expect {
          FactoryGirl.create(:product)
        }.to change(ProductMessage, :count).by(3)
      end

      it 'creates 3 type system messages' do
        product = FactoryGirl.create(:product)
        expect(product.product_messages.enqueued_event.first).to be_persisted
        expect(product.product_messages.goaled_event.first).to be_persisted
        expect(product.product_messages.dequeued_event.first).to be_persisted
      end
    end
  end
end
