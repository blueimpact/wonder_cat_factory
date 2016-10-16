require 'rails_helper'

RSpec.describe Users::SessionsController, type: :controller do
  describe 'GET #new' do
    it 'assigns new user as @user' do
      get :new
      expect(assigns(:user)).to be_new_record
    end

    it 'redirects to root if signed in' do
      user = FactoryGirl.create(:user)
      controller.sign_in user
      get :new
      expect(response).to redirect_to root_url
    end
  end

  describe 'POST #create' do
    context 'with new user' do
      let(:email) { 'user@wonder-cat-factory.test' }

      it 'creates unconfirmed user' do
        expect {
          post :create, { user: { email: email } }
        }.to change(User, :count).by(1)
        expect(assigns(:user)).not_to be_confirmed
      end
    end

    context 'with existent user' do
      let(:user) { FactoryGirl.create(:user) }

      it 'sets reconfirmation attributes' do
        expect {
          post :create, { user: { email: user.email } }
        }.to change { user.reload.pending_reconfirmation? }.from(false).to(true)
      end
    end
  end
end
