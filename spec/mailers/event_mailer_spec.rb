require 'rails_helper'

RSpec.describe EventMailer, type: :mailer do
  let(:seller) { FactoryGirl.create(:user, :seller) }
  let(:user) { FactoryGirl.create(:user) }

  let(:product) {
    FactoryGirl.create(:product, :with_one_picture, goal: 1, user: seller)
  }

  describe 'to_user' do
    let(:mail) { EventMailer.to_user(event, bid) }

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

  describe 'to_seller' do
    let(:mail) { EventMailer.to_seller(event) }

    context 'with started event' do
      let(:event) { Events::StartedEvent.last }

      before do
        product.update! started_at: Time.current
      end

      it 'renders the headers' do
        system_message = seller.system_messages.started_event.first
        expect(mail.subject).to eq system_message.subject
        expect(mail.to).to eq [seller.email]
        expect(mail.from).to eq ['noreply@mail.wonder-cat-factory.test']
      end
    end

    context 'with enqueued event' do
      let!(:bid) { product.bids.create(user: user) }
      let(:event) { Events::EnqueuedEvent.last }

      it 'renders the headers' do
        system_message = seller.system_messages.enqueued_event.first
        expect(mail.subject).to eq system_message.subject
        expect(mail.to).to eq [seller.email]
        expect(mail.from).to eq ['noreply@mail.wonder-cat-factory.test']
      end
    end

    context 'with goaled event' do
      let!(:bid) { product.bids.create(user: user) }
      let(:event) { Events::GoaledEvent.last }

      it 'renders the headers' do
        system_message = seller.system_messages.goaled_event.first
        expect(mail.subject).to eq system_message.subject
        expect(mail.to).to eq [seller.email]
        expect(mail.from).to eq ['noreply@mail.wonder-cat-factory.test']
      end
    end
  end
end
