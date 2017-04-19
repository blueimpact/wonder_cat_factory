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

      context 'with product message' do
        let!(:product_message) {
          FactoryGirl.create(
            :product_message, product: product, message_type: :goaled_event
          )
        }

        it 'renders the headers' do
          expect(mail.subject).to eq product_message.subject
          expect(mail.to).to eq [bid.user.email]
          expect(mail.from).to eq ['noreply@mail.wonder-cat-factory.test']
        end
      end

      context 'without product message' do
        it 'renders the headers' do
          expect(mail.subject).to eq I18n.t('event_mailer.to_user.subject')
          expect(mail.to).to eq [bid.user.email]
          expect(mail.from).to eq ['noreply@mail.wonder-cat-factory.test']
        end
      end
    end

    context 'with enqueued event' do
      let!(:bid) { product.bids.create(user: user) }
      let(:event) { Events::EnqueuedEvent.last }

      context 'with product message' do
        let!(:product_message) {
          FactoryGirl.create(
            :product_message, product: product, message_type: :enqueued_event
          )
        }
        it 'renders the headers' do
          expect(mail.subject).to eq product_message.subject
          expect(mail.to).to eq [bid.user.email]
          expect(mail.from).to eq ['noreply@mail.wonder-cat-factory.test']
        end
      end

      context 'without product message' do
        it 'renders the headers' do
          expect(mail.subject).to eq I18n.t('event_mailer.to_user.subject')
          expect(mail.to).to eq [bid.user.email]
          expect(mail.from).to eq ['noreply@mail.wonder-cat-factory.test']
        end
      end
    end

    context 'with dequeued event' do
      let!(:bid) { product.bids.create(user: user, accepted_at: Time.current) }
      let(:event) { Events::DequeuedEvent.last }

      context 'with product message' do
        let!(:product_message) {
          FactoryGirl.create(
            :product_message, product: product, message_type: :dequeued_event
          )
        }
        it 'renders the headers' do
          expect(mail.subject).to eq product_message.subject
          expect(mail.to).to eq [bid.user.email]
          expect(mail.from).to eq ['noreply@mail.wonder-cat-factory.test']
        end
      end

      context 'without product message' do
        it 'renders the headers' do
          expect(mail.subject).to eq I18n.t('event_mailer.to_user.subject')
          expect(mail.to).to eq [bid.user.email]
          expect(mail.from).to eq ['noreply@mail.wonder-cat-factory.test']
        end
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

      context 'with system_message' do
        let!(:system_message) {
          FactoryGirl.create(
            :system_message, user: seller, message_type: :started_event
          )
        }

        it 'renders the headers' do
          expect(mail.subject).to eq system_message.subject
          expect(mail.to).to eq [seller.email]
          expect(mail.from).to eq ['noreply@mail.wonder-cat-factory.test']
        end
      end

      context 'without system_message' do
        it 'renders the headers default subject' do
          expect(mail.subject).to eq I18n.t('event_mailer.to_seller.subject')
          expect(mail.to).to eq [seller.email]
          expect(mail.from).to eq ['noreply@mail.wonder-cat-factory.test']
        end
      end
    end

    context 'with enqueued event' do
      let!(:bid) { product.bids.create(user: user) }
      let(:event) { Events::EnqueuedEvent.last }

      context 'with system_message' do
        let!(:system_message) {
          FactoryGirl.create(
            :system_message, user: seller, message_type: :enqueued_event
          )
        }

        it 'renders the headers' do
          expect(mail.subject).to eq system_message.subject
          expect(mail.to).to eq [seller.email]
          expect(mail.from).to eq ['noreply@mail.wonder-cat-factory.test']
        end
      end

      context 'without system_message' do
        it 'renders the headers' do
          expect(mail.subject).to eq I18n.t('event_mailer.to_seller.subject')
          expect(mail.to).to eq [seller.email]
          expect(mail.from).to eq ['noreply@mail.wonder-cat-factory.test']
        end
      end
    end

    context 'with goaled event' do
      let!(:bid) { product.bids.create(user: user) }
      let(:event) { Events::GoaledEvent.last }

      context 'with system_message' do
        let!(:system_message) {
          FactoryGirl.create(
            :system_message, user: seller, message_type: :goaled_event
          )
        }

        it 'renders the headers' do
          expect(mail.subject).to eq system_message.subject
          expect(mail.to).to eq [seller.email]
          expect(mail.from).to eq ['noreply@mail.wonder-cat-factory.test']
        end
      end

      context 'without system_message' do
        it 'renders the headers' do
          expect(mail.subject).to eq I18n.t('event_mailer.to_seller.subject')
          expect(mail.to).to eq [seller.email]
          expect(mail.from).to eq ['noreply@mail.wonder-cat-factory.test']
        end
      end
    end
  end
end
