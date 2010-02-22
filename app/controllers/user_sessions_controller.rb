class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => :create
  before_filter :require_user, :only => :destroy

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = t('user_sessions.create.success')
      redirect_back_or_default dashboard_path
    else
      flash[:error] = @user_session.errors.on(:base)
      redirect_to root_path
    end
  end

  def destroy
    current_user_session.destroy
    flash[:notice] = t('user_sessions.destroy.success')
    redirect_back_or_default root_url
  end
end