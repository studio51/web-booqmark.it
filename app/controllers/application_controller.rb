class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  protect_from_forgery with: :exception

  layout :layout_by_resource

  protected

    def layout_by_resource
      if devise_controller?
        'authentication'
      else
        'application'
      end
    end

    def paginate object
      object.paginate(page: params[:page])
    end
end
