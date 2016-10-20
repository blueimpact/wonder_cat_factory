require 'rails_helper'

RSpec.describe Events::EnqueuedEvent, type: :model do
  describe '.trigger' do
    let(:product) { FactoryGirl.create(:product, goal: 2) }

    it 'creates GoaledEvent if goaling' do
      expect {
        FactoryGirl.create_list(:bid, 2, product: product)
      }.to change(Events::GoaledEvent, :count).by(1)
    end
  end
end
