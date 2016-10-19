require 'rails_helper'

shared_examples_for Manage::InstructionsController do
  let(:valid_attributes) {
    {
      type: 'Instructions::DequeuedInstruction',
      body: 'This is instruction.'
    }
  }

  let(:invalid_attributes) {
    {
      body: nil
    }
  }

  describe 'GET #index' do
    it 'assigns instructions as @instructions' do
      instruction = FactoryGirl.create(:dequeued_instruction, product: product)
      get :index, { product_id: product.id }
      expect(assigns(:instructions)).to eq([instruction])
    end

    it 'assigns new instruction if not exists' do
      get :index, { product_id: product.id }
      expect(assigns(:instructions).first)
        .to be_a_new(Instructions::DequeuedInstruction)
    end
  end

  describe 'GET #new' do
    it 'assigns a new instruction as @instruction' do
      get :new, { product_id: product.id,
                  type: 'Instructions::EnqueuedInstruction' }
      expect(assigns(:instruction)).to be_a_new(Instruction)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested instruction as @instruction' do
      instruction = FactoryGirl.create(:started_instruction, product: product)
      get :edit, { product_id: product.id, id: instruction.id }
      expect(assigns(:instruction)).to eq(instruction)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Instruction' do
        expect {
          post :create, { product_id: product.id,
                          instruction: valid_attributes }
        }.to change(Instruction, :count).by(1)
      end

      it 'assigns a newly created instruction as @instruction' do
        post :create, { product_id: product.id,
                        instruction: valid_attributes }
        expect(assigns(:instruction)).to be_a(Instruction)
        expect(assigns(:instruction)).to be_persisted
      end

      it 'redirects to the instruction list' do
        post :create, { product_id: product.id,
                        instruction: valid_attributes }
        expect(response).to redirect_to([role, product, :instructions])
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved instruction as @instruction' do
        post :create, { product_id: product.id,
                        instruction: invalid_attributes }
        expect(assigns(:instruction)).to be_a_new(Instruction)
      end

      it "re-renders the 'edit' template" do
        post :create, { product_id: product.id,
                        instruction: invalid_attributes }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) {
        {
          body: 'This is new body.'
        }
      }

      it 'updates the requested instruction' do
        instruction = FactoryGirl.create(:started_instruction, product: product)
        put :update, { product_id: product.id,
                       id: instruction.id,
                       instruction: new_attributes }
        instruction.reload
      end

      it 'assigns the requested instruction as @instruction' do
        instruction = FactoryGirl.create(:started_instruction, product: product)
        put :update, { product_id: product.id,
                       id: instruction.id,
                       instruction: valid_attributes }
        expect(assigns(:instruction)).to eq(instruction)
      end

      it 'redirects to the instruction list' do
        instruction = FactoryGirl.create(:started_instruction, product: product)
        put :update, { product_id: product.id,
                       id: instruction.id,
                       instruction: valid_attributes }
        expect(response).to redirect_to([role, product, :instructions])
      end
    end

    context 'with invalid params' do
      it 'assigns the instruction as @instruction' do
        instruction = FactoryGirl.create(:started_instruction, product: product)
        put :update, { product_id: product.id,
                       id: instruction.id,
                       instruction: invalid_attributes }
        expect(assigns(:instruction)).to eq(instruction)
      end

      it "re-renders the 'edit' template" do
        instruction = FactoryGirl.create(:started_instruction, product: product)
        put :update, { product_id: product.id,
                       id: instruction.id,
                       instruction: invalid_attributes }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested instruction' do
      instruction = FactoryGirl.create(:started_instruction, product: product)
      expect {
        delete :destroy, { product_id: product.id, id: instruction.id }
      }.to change(Instruction, :count).by(-1)
    end

    it 'redirects to the instruction list' do
      instruction = FactoryGirl.create(:started_instruction, product: product)
      delete :destroy, { product_id: product.id, id: instruction.id }
      expect(response).to redirect_to([role, product, :instructions])
    end
  end
end

RSpec.describe Admin::InstructionsController, type: :controller do
  login_admin
  let(:role) { :admin }
  let(:product) { FactoryGirl.create(:product) }
  it_behaves_like Manage::InstructionsController
end

RSpec.describe Seller::InstructionsController, type: :controller do
  login_seller
  let(:role) { :seller }
  let(:product) { FactoryGirl.create(:product, user: @current_user) }
  it_behaves_like Manage::InstructionsController
end
