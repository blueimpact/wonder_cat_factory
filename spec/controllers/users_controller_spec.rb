require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #available' do
    let(:valid_attributes) {
      {
        email: 'user@wonder-cat-factory.test',
        password: 'p@ssw0rd'
      }
    }

    it 'returns http success' do
      xhr :get, :available, user: valid_attributes
      expect(response).to have_http_status(:success)
    end
  end
end
