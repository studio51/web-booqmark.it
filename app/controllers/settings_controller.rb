class SettingsController < ApplicationController

  def index
    @settings = Setting.all
  end

  private

    def set_setting
      @setting = Setting.find_by_id(params[:id])
    end
end
