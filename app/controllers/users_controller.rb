class UsersController < ApplicationController
  def index
    @users = paginate User.all
  end

  def show
    set_user

    @collections = User.all
  end

  def edit
    set_user
  end

  def new
    @user = User.new
    @profile = @user.build_profile()
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: t("messages.success.created", obj: t("models.user.name"))}
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, notice: t("messages.error.created", obj: t("models.user.name"))}
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: t("messages.success.updated", obj: t("models.user.name"))}
        format.json { render json: { :status => 'updated' } }

      else
        format.html { render :new, error: t("messages.error.updated", obj: t("models.user.name"))}
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @user.destroy
        format.html { redirect_to users_path, notice: t("messages.success.deleted", obj: t("models.user.name"))}
        format.json { head :no_content }
      else
        format.html { redirect_to users_path, error: t("messages.error.deleted", obj: t("models.user.name"))}
        format.json { head :no_content }
      end
    end
  end

  private

    def set_user
      @user = User.find_by_id(params[:id])
    end

    def user_params
      params.require(:user).permit(
        :email,
        :password,
        :password_confirmation,
        profile_attributes: [:firstname, :surname]
      )
    end
end
