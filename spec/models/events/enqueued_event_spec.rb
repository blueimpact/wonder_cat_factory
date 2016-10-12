require 'rails_helper'

RSpec.describe Events::EnqueuedEvent, type: :model do
  describe '.trigger' do
    let(:product) { FactoryGirl.create(:product) }

    let(:bid) { FactoryGirl.create(:bid, product: product) }

    it 'returns event' do
      expect(described_class.trigger(bid)).to be_a described_class
    end

    context 'with goaling product' do
      let(:product) { FactoryGirl.create(:product, goal: 2) }

      it 'creates GoaledEvent if goaling' do
        FactoryGirl.create(:bid, product: product)
        expect {
          described_class.trigger(bid)
        }.to change(Events::GoaledEvent, :count).by(1)
      end
    end
  end
end
