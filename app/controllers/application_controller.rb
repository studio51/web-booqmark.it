class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  protect_from_forgery with: :exception

  layout :layout_by_resource
  def ensure_signup_complete
    # Ensure we don't go into an infinite loop
    return if action_name == 'finish_signup'

    # Redirect to the 'finish_signup' page if the user
    # email hasn't been verified yet
    if current_user && !current_user.email_verified?
      redirect_to finish_signup_path(current_user)
    end
  end
  protected

    def layout_by_resource
      if devise_controller?
        'authentication'
      else
        'application'
      end
    end

    def paginate object
      # object.paginate(page: params[:page])
      object
    end
end
