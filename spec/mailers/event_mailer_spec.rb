require 'rails_helper'

RSpec.describe EventMailer, type: :mailer do
  let(:product) { FactoryGirl.create(:product, goal: 1) }

  describe 'to_user' do
    let(:mail) { EventMailer.to_user(event, bid) }
    let(:user) { FactoryGirl.create(:user) }

    context 'with goaled event' do
      let!(:bid) { product.bids.create(user: user) }
      let(:event) { Events::GoaledEvent.last }

      it 'renders the headers' do
        expect(mail.subject).to eq event.to_message(:short)
        expect(mail.to).to eq [bid.user.email]
        expect(mail.from).to eq ['noreply@mail.wonder-cat-factory.test']
      end
    end

    context 'with enqueued event' do
      let!(:bid) { product.bids.create(user: user) }
      let(:event) { Events::EnqueuedEvent.last }

      it 'renders the headers' do
        expect(mail.subject).to eq event.to_message(:short)
        expect(mail.to).to eq [bid.user.email]
        expect(mail.from).to eq ['noreply@mail.wonder-cat-factory.test']
      end
    end

    context 'with dequeued event' do
      let!(:bid) { product.bids.create(user: user, accepted_at: Time.current) }
      let(:event) { Events::DequeuedEvent.last }

      it 'renders the headers' do
        expect(mail.subject).to eq event.to_message(:short)
        expect(mail.to).to eq [bid.user.email]
        expect(mail.from).to eq ['noreply@mail.wonder-cat-factory.test']
      end
    end
  end

  # describe "to_seller" do
  #   let(:mail) { EventMailer.to_seller }

  #   it "renders the headers" do
  #     expect(mail.subject).to eq("To seller")
  #     expect(mail.to).to eq(["to@example.org"])
  #     expect(mail.from).to eq(["from@example.com"])
  #   end
  # end
end
