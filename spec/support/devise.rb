Module.new do
  module Controller
    def login_user
      before do
        @current_user = block_given? ? yield : FactoryGirl.create(:user)
        sign_in @current_user
      end
    end

    def login_admin
      login_user do
        FactoryGirl.create(:user, :admin)
      end
    end
  end

  module Request
    def login_user
      before do
        @current_user = FactoryGirl.create(:user)
        post_via_redirect(
          user_session_path,
          'user[email]' => @current_user.email,
          'user[password]' => @current_user.password
        )
      end
    end
  end

  RSpec.configure do |config|
    config.include Devise::TestHelpers, type: :controller
    config.extend Controller, type: :controller
    config.extend Request, type: :request
  end
end
