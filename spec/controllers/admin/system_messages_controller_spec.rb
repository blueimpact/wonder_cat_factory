require 'rails_helper'

RSpec.describe Admin::SystemMessagesController, type: :controller do
  login_admin

  let(:user) { FactoryGirl.create(:user) }
  let(:seller) { FactoryGirl.create(:user, :seller) }

  let(:valid_attributes) {
    {
      message_type: 'started_event',
      subject: 'Subject Subject Subject',
      body: 'Body Body Body'
    }
  }

  let(:invalid_attributes) { { subject: nil } }

  describe 'GET #index' do
    it "assigns seller's system_message as @system_messages" do
      system_messages = FactoryGirl.create_list(
        :system_message,
        3,
        user: seller
      )
      get :index, { user_id: seller.id }
      expect(assigns(:system_messages)).to eq(system_messages)
    end

    it "does not show user's system_message page" do
      expect{
        get :index, { user_id: user.id }
      }.to raise_exception(ActiveRecord::RecordNotFound)
    end
  end

  describe 'GET #show' do
    it 'assigns the requested system_message as @system_message' do
      system_message = FactoryGirl.create(:system_message, user: seller)

      get :show, { id: system_message.to_param, user_id: seller.id }
      expect(assigns(:system_message)).to eq(system_message)
    end
  end

  describe 'GET #new' do
    it 'assigns a new system_message as @system_message' do
      get :new, { user_id: seller.id }
      expect(assigns(:system_message)).to be_a_new(SystemMessage)
    end

    it 'assigns non-used message_type as @selectable_message_types' do
      FactoryGirl.create(
        :system_message, user: seller, message_type: 'started_event'
      )
      get :new, { user_id: seller.id }
      expect(assigns(:selectable_message_types)).to eq(
        { 'enqueued_event' => 2, 'goaled_event' => 3 }
      )
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested admin_system_message as @admin_system_message' do
      system_message = FactoryGirl.create(:system_message, user: seller)

      get :edit, { id: system_message.to_param, user_id: seller.id }
      expect(assigns(:system_message)).to eq(system_message)
    end

    it 'assigns non-used message_type as @selectable_message_types' do
      system_message = FactoryGirl.create(
        :system_message, user: seller, message_type: 'started_event'
      )
      FactoryGirl.create(
        :system_message, user: seller, message_type: 'enqueued_event'
      )

      get :edit, { id: system_message.to_param, user_id: seller.id }
      expect(assigns(:selectable_message_types)).to eq(
        { 'started_event' => 1, 'goaled_event' => 3 }
      )
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new SystemMessage' do
        expect {
          post :create, { system_message: valid_attributes, user_id: seller.id }
        }.to change(SystemMessage, :count).by(1)
      end

      it 'assigns a newly created system_message as @system_message' do
        post :create, { system_message: valid_attributes, user_id: seller.id }
        expect(assigns(:system_message)).to be_a(SystemMessage)
        expect(assigns(:system_message)).to be_persisted
      end

      it 'redirects to the users list' do
        post :create, { system_message: valid_attributes, user_id: seller.id }
        expect(response).to redirect_to(admin_user_system_messages_url)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved user as @system_message' do
        post :create, { system_message: invalid_attributes, user_id: seller.id }
        expect(assigns(:system_message)).to be_a_new(SystemMessage)
      end

      it "re-renders the 'new' template" do
        post :create, { system_message: invalid_attributes, user_id: seller.id }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) {
        {
          subject: 'New subject'
        }
      }

      it 'updates the requested system_message' do
        system_message = FactoryGirl.create(:system_message, user: seller)

        put :update, {
          id: system_message.to_param,
          user_id: seller.id,
          system_message: new_attributes
        }
        system_message.reload
        expect(system_message.subject).to eq 'New subject'
      end

      it 'assigns the requested system_message as @system_message' do
        system_message = FactoryGirl.create(:system_message, user: seller)

        put :update, {
          id: system_message.to_param,
          user_id: seller.id,
          system_message: new_attributes
        }
        expect(assigns(:system_message)).to eq(system_message)
      end

      it 'redirects to the system_message' do
        system_message = FactoryGirl.create(:system_message, user: seller)

        put :update, {
          id: system_message.to_param,
          user_id: seller.id,
          system_message: new_attributes
        }
        expect(response).to redirect_to([:admin, seller, system_message])
      end
    end

    context 'with invalid params' do
      it 'assigns the system_message as @system_message' do
        system_message = FactoryGirl.create(:system_message, user: seller)

        put :update, {
          id: system_message.to_param,
          user_id: seller.id,
          system_message: invalid_attributes
        }
        expect(assigns(:system_message)).to eq(system_message)
      end

      it "re-renders the 'edit' template" do
        system_message = FactoryGirl.create(:system_message, user: seller)

        put :update, {
          id: system_message.to_param,
          user_id: seller.id,
          system_message: invalid_attributes
        }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested user' do
      system_message = FactoryGirl.create(:system_message, user: seller)
      expect {
        delete :destroy, { id: system_message.to_param, user_id: seller.id }
      }.to change(SystemMessage, :count).by(-1)
    end

    it 'redirects to the users list' do
      system_message = FactoryGirl.create(:system_message, user: seller)
      delete :destroy, { id: system_message.to_param, user_id: seller.id }
      expect(response).to redirect_to(admin_user_system_messages_url)
    end
  end
end
