class UsersController < ApplicationController
  respond_to :html, :json

  def index
    @users = paginate User.all
  end

  def show
    @following = 15
    @followers = 10

    @bookmarks = user.bookmarks
  end

  def edit
    user
    @profile = user.build_profile
  end

  def new
    @user    = User.new
    @profile = @user.build_profile
  end

  def create
    @user = User.new(user_params)

    if @user.create
      flash[:notice] = t('messages.methods.create', model: 'user')
      respond_with user
    else
      flash[:notice] = t('messages.methods.create', model: 'user')
      respond_with user, action: :new
    end
  end

  def update
    if user.update(user_params)
      flash[:notice] = t('messages.methods.update', model: 'user', case: 'error')
      # respond_with user
      redirect_to users_path
    else
      flash[:notice] = t('messages.methods.update', model: 'user', case: 'success')
      respond_with user, action: :new
    end
  end

  def destroy
    respond_with @user.destroy
  end

  private

    def user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(
        :email,
        :password,
        :password_confirmation,
        profile_attributes: [
          :user_id,
          :avatar,
          :first_name,
          :last_name,
          :description
        ]
      )
    end
end
