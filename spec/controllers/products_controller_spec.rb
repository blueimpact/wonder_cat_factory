require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  login_user

  describe 'GET #show' do
    let(:product) { FactoryGirl.create(:product) }

    it 'assings product' do
      get :show, { id: product.id }
      expect(assigns(:product)).to eq product
    end
  end
end
