require 'rails_helper'

RSpec.describe Users::ConfirmationsController, type: :controller do
  describe 'GET #show' do
    context 'when confirm' do
      let(:user) { FactoryGirl.create(:user, :unconfirmed) }

      context 'with valid token' do
        it 'confirms user' do
          expect {
            get :show, { confirmation_token: user.confirmation_token }
          }.to change { user.reload.confirmed? }.from(false).to(true)
        end

        it 'redirects to root' do
          get :show, { confirmation_token: user.confirmation_token }
          expect(response).to redirect_to root_url
        end
      end

      context 'with expired token' do
        before do
          user.update confirmation_sent_at: (User.confirm_within + 1.year).ago
        end

        it 'renders sessions/new template' do
          get :show, { confirmation_token: user.confirmation_token }
          expect(response).to render_template 'users/sessions/new'
        end
      end
    end

    context 'when update email' do
      login_user

      let(:user) { @current_user }

      before do
        user.update email: 'new@wonder-cat-factory.test'
      end

      context 'with valid token' do
        it 'updates email' do
          get :show, { confirmation_token: user.confirmation_token }
          user.reload
          expect(user.email).to eq 'new@wonder-cat-factory.test'
          expect(user.unconfirmed_email).to eq nil
        end

        it 'redirects to edit page' do
          get :show, { confirmation_token: user.confirmation_token }
          expect(response).to redirect_to [:edit, :user, :registration]
        end

        it 'signs in if not signed in' do
          controller.sign_out
          expect {
            get :show, { confirmation_token: user.confirmation_token }
          }.to change(controller, :signed_in?).from(false).to(true)
        end
      end

      context 'with expired token' do
        before do
          user.update confirmation_sent_at: (User.confirm_within + 1.year).ago
        end

        it 'renders registrations/edit template' do
          get :show, { confirmation_token: user.confirmation_token }
          expect(response).to render_template 'users/registrations/edit'
        end

        it 'redirects to edit page if not signed in' do
          controller.sign_out
          get :show, { confirmation_token: user.confirmation_token }
          expect(response).to redirect_to [:edit, :user, :registration]
        end
      end

      context 'with invalid token' do
        it 'renders registrations/edit template' do
          get :show, { confirmation_token: 'invalid token' }
          expect(response).to render_template 'users/registrations/edit'
        end
      end
    end
  end
end
