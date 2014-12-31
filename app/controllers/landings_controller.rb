class LandingsController < ApplicationController
  skip_before_filter :authenticate_user!

  layout 'landing'

  def index

  end
end
