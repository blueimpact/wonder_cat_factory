class Users::RegistrationsController < Devise::RegistrationsController
  def sign_up_params
    params.require(:user).permit(:email, :password, :label, :birthday)
  end
end
