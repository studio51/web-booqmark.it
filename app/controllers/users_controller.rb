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
  end

  def new
    @user    = User.new
    @profile = @user.build_profile
  end

  def create
    @user = User.new(user_params)

    respond_with @user.save
  end

  def update
    respond_with user.update(user_params)
  end

  def destroy
    respond_with @user.destroy
  end

  private

    def user
      @user = User.find_by_id(params[:id])
    end

    def user_params
      params.require(:user).permit(
        :email,
        :password,
        :password_confirmation,
        profile_attributes: [
          :first_name,
          :last_name,
          :description
        ]
      )
    end
end
