# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class UserApplicationController < ApplicationController
  layout 'application'

  before_filter :require_user
  before_filter :setup

  def setup
    unless current_restaurant
      redirect_to setup_wizard_path
    end
  end
end