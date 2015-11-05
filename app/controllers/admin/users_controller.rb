class Admin::UsersController < AdminController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /admin/users
  def index
    @users = User.order(:id).page(params[:page]).per(100)
    case params[:role]
    when 'admin'
      @users = @users.admin
    when 'seller'
      @users = @users.seller
    end
  end

  # GET /admin/users/1
  def show
  end

  # GET /admin/users/new
  def new
    @user = User.new
  end

  # GET /admin/users/1/edit
  def edit
  end

  # POST /admin/users
  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_path, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /admin/users/1
  def update
    @user.try :skip_reconfirmation!
    if @user.update(user_params)
      redirect_to admin_users_path, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/users/1
  def destroy
    @user.destroy
    redirect_to admin_users_url, notice: 'User was successfully destroyed.'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :username, :email, :password, :label, :is_admin, :is_seller
    )
  end
end
