require 'rails_helper'

RSpec.describe Admin::StripeAccountsController, type: :controller do
  describe 'POST #create' do
    login_admin

    context 'with valid params' do
      it 'creates a new stripe account' do
        user = FactoryGirl.create(:user)
        expect {
          post :create, { user_id: user.id }
        }.to change(StripeAccount, :count).by(1)
      end

      it 'assigns the requested user as @user' do
        user = FactoryGirl.create(:user)
        post :create, { user_id: user.id }
        expect(assigns(:user)).to eq(user)
      end

      it 'redirects to the user page' do
        user = FactoryGirl.create(:user)
        post :create, { user_id: user.id }
        expect(response).to redirect_to(admin_user_url(user))
      end
    end
  end
end
