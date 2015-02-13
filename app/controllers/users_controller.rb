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
    @profile = user.build_profile()
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
    # if user.update(user_params)
    #   flash[:notice] = t('messages.methods.update', model: 'user', case: 'error')
    #   # respond_with user
    #   redirect_to users_path
    # else
    #   flash[:notice] = t('messages.methods.update', model: 'user', case: 'success')
    #   respond_with user, action: :new
    # end
    respond_to do |format|
      if @user.update(user_params)
        sign_in(@user == current_user ? @user : current_user, :bypass => true)
        format.html { redirect_to @user, notice: 'Your profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def finish_signup
    # authorize! :update, @user
    if request.patch? && params[:user] #&& params[:user][:email]
      if @user.update(user_params)
        @user.skip_reconfirmation!
        sign_in(@user, :bypass => true)
        redirect_to @user, notice: 'Your profile was successfully updated.'
      else
        @show_errors = true
      end
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

      # accessible = [ :name, :email ] # extend with your own params
      # accessible << [ :password, :password_confirmation ] unless params[:user][:password].blank?
      # params.require(:user).permit(accessible)

      params.require(:user).permit(
        :email,
        :password,
        :password_confirmation,
        profile_attributes: [
          :avatar,
          :first_name,
          :last_name,
          :description
        ]
      )
    end
end
