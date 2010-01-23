# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class UserApplicationController < ApplicationController
  layout 'application'

  before_filter :require_user
  before_filter :setup
  before_filter :set_timezone

  def set_timezone
    if current_restaurant
      Time.zone = current_restaurant.timezone
    end
  end

  def setup
    unless current_restaurant
      redirect_to setup_wizard_path
    end
  end

  def responder
    AppResponder
  end
end