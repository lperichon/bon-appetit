class Admin::UserSessionsController < ApplicationController
  layout 'admin'
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_admin, :only => :destroy

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Login successful!"
      redirect_back_or_default admin_restaurants_url
    else
      flash[:error] = "Your account is not active" if @user_session.errors.on(:base)
      render :action => :new
    end
  end

  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_back_or_default admin_login_url
  end
end