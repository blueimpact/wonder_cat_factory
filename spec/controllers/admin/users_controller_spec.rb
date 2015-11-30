require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  login_admin

  let(:valid_attributes) {
    {
      email: 'user@kawaii-inc.com',
      password: 'p@ssw0rd'
    }
  }

  let(:invalid_attributes) { { email: nil } }

  describe 'GET #index' do
    it 'assigns all users as @users' do
      user = User.create! valid_attributes
      get :index
      expect(assigns(:users)).to eq [@current_user, user]
    end

    it 'filters admins' do
      admins = [@current_user, FactoryGirl.create(:user, :admin)]
      FactoryGirl.create(:user)
      get :index, { role: 'admin' }
      expect(assigns(:users)).to eq admins
    end

    it 'filters sellers' do
      sellers = FactoryGirl.create_list(:user, 2, :seller)
      FactoryGirl.create(:user)
      get :index, { role: 'seller' }
      expect(assigns(:users)).to eq sellers
    end
  end

  describe 'GET #show' do
    it 'assigns the requested user as @user' do
      user = User.create! valid_attributes
      get :show, { id: user.to_param }
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'GET #new' do
    it 'assigns a new user as @user' do
      get :new, {}
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested user as @user' do
      user = User.create! valid_attributes
      get :edit, { id: user.to_param }
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new User' do
        expect {
          post :create, { user: valid_attributes }
        }.to change(User, :count).by(1)
      end

      it 'assigns a newly created user as @user' do
        post :create, { user: valid_attributes }
        expect(assigns(:user)).to be_a(User)
        expect(assigns(:user)).to be_persisted
      end

      it 'redirects to the users list' do
        post :create, { user: valid_attributes }
        expect(response).to redirect_to(admin_users_url)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved user as @user' do
        post :create, { user: invalid_attributes }
        expect(assigns(:user)).to be_a_new(User)
      end

      it "re-renders the 'new' template" do
        post :create, { user: invalid_attributes }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) {
        {
          label: 'New Label'
        }
      }

      it 'updates the requested user' do
        user = User.create! valid_attributes
        put :update, { id: user.to_param, user: new_attributes }
        user.reload
        expect(user.label).to eq 'New Label'
      end

      it 'assigns the requested user as @user' do
        user = User.create! valid_attributes
        put :update, { id: user.to_param, user: new_attributes }
        expect(assigns(:user)).to eq(user)
      end

      it 'redirects to the users list' do
        user = User.create! valid_attributes
        put :update, { id: user.to_param, user: new_attributes }
        expect(response).to redirect_to(admin_users_url)
      end

      it 'ignores empty password' do
        user = User.create! valid_attributes
        attrs = new_attributes.merge(password: '')
        put :update, { id: user.to_param, user: attrs }
        user.reload
        expect(user.label).to eq 'New Label'
      end
    end

    context 'with invalid params' do
      it 'assigns the user as @user' do
        user = User.create! valid_attributes
        put :update, { id: user.to_param, user: invalid_attributes }
        expect(assigns(:user)).to eq(user)
      end

      it "re-renders the 'edit' template" do
        user = User.create! valid_attributes
        put :update, { id: user.to_param, user: invalid_attributes }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested user' do
      user = User.create! valid_attributes
      expect {
        delete :destroy, { id: user.to_param }
      }.to change(User, :count).by(-1)
    end

    it 'redirects to the users list' do
      user = User.create! valid_attributes
      delete :destroy, { id: user.to_param }
      expect(response).to redirect_to(admin_users_url)
    end
  end
end
