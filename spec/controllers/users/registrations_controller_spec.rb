require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  login_user

  describe 'GET #edit' do
    it 'assigns current_user as @user' do
      get :edit
      expect(assigns(:user)).to eq @current_user
    end
  end

  describe 'PUT #update' do
    let(:new_attributes) {
      {
        label: 'New Label'
      }
    }

    it 'updates attributes' do
      put :update, { user: new_attributes }
      @current_user.reload
      expect(@current_user.attributes).to include new_attributes.stringify_keys
    end

    it 'updates confirmation attributes for email' do
      new_attributes[:email] = 'new@wonder-cat-factory.test'
      expect {
        put :update, { user: new_attributes }
      }.not_to change { @current_user.reload.email }
      expect(@current_user.unconfirmed_email).to eq new_attributes[:email]
      expect(@current_user.confirmation_token).to be_present
      expect(@current_user.confirmation_sent_at).to be_present
    end
  end
end
