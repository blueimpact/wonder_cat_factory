require 'rails_helper'

RSpec.describe Admin::SystemMessagesController, type: :controller do
  login_admin

  before do
    @user = FactoryGirl.create(:user)
    @seller = FactoryGirl.create(:user, :seller)
  end

  let(:invalid_attributes) { { title: nil } }

  describe 'GET #index' do
    it "assigns seller's system_message as @system_messages" do
      get :index, { user_id: @seller.id }
      expect(assigns(:system_messages)).to eq(@seller.system_messages)
    end

    it "does not show user's system_message page" do
      expect{
        get :index, { user_id: @user.id }
      }.to raise_exception(ActiveRecord::RecordNotFound)
    end
  end

  describe 'GET #show' do
    it 'assigns the requested system_message as @system_message' do
      system_message = @seller.system_messages.first
      get :show, { id: system_message.to_param, user_id: @seller.id }
      expect(assigns(:system_message)).to eq(system_message)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested admin_system_message as @admin_system_message' do
      system_message = @seller.system_messages.first
      get :edit, { id: system_message.to_param, user_id: @seller.id }
      expect(assigns(:system_message)).to eq(system_message)
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) {
        {
          title: 'New Title'
        }
      }

      it 'updates the requested system_message' do
        system_message = @seller.system_messages.first
        put :update, {
          id: system_message.to_param,
          user_id: @seller.id,
          system_message: new_attributes
        }
        system_message.reload
        expect(system_message.title).to eq 'New Title'
      end

      it 'assigns the requested system_message as @system_message' do
        system_message = @seller.system_messages.first
        put :update, {
          id: system_message.to_param,
          user_id: @seller.id,
          system_message: new_attributes
        }
        expect(assigns(:system_message)).to eq(system_message)
      end

      it 'redirects to the system_message' do
        system_message = @seller.system_messages.first
        put :update, {
          id: system_message.to_param,
          user_id: @seller.id,
          system_message: new_attributes
        }
        expect(response).to redirect_to([:admin, @seller, system_message])
      end
    end

    context 'with invalid params' do
      it 'assigns the system_message as @system_message' do
        system_message = @seller.system_messages.first
        put :update, {
          id: system_message.to_param,
          user_id: @seller.id,
          system_message: invalid_attributes
        }
        expect(assigns(:system_message)).to eq(system_message)
      end

      it "re-renders the 'edit' template" do
        system_message = @seller.system_messages.first
        put :update, {
          id: system_message.to_param,
          user_id: @seller.id,
          system_message: invalid_attributes
        }
        expect(response).to render_template('edit')
      end
    end
  end
end
