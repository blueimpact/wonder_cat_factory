require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  login_user

  describe 'GET #bidden' do
    it 'filters by bidden' do
      products = FactoryGirl.create_list(:product, 2, :with_one_picture)
      products.each do |product|
        @current_user.bid product
      end
      FactoryGirl.create(:product, :with_one_picture)

      get :bidden
      expect(assigns(:products).to_a).to eq products
    end
  end
end
