class PasswordResetsController < ApplicationController
  before_filter :require_no_user
  before_filter :load_user_using_perishable_token, :only => [:edit, :update]

  def create
    @user = User.find_by_email(params[:email])
    if @user
      @user.deliver_password_reset_instructions!
      flash[:notice] = t('password_resets.create.success')
      redirect_to login_url
    else
      flash[:notice] = t('password_resets.create.failure')
      render :action => :new  
    end
  end

  def update
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.save
      flash[:notice] = t('password_resets.update.success')
      redirect_to dashboard_path
    else
      render :action => :edit
    end
  end

  private
  def load_user_using_perishable_token
    @user = User.find_using_perishable_token(params[:id])
    unless @user
      flash[:notice] = t('password_resets.perishable_token_not_found')
      redirect_to login_url
    end
  end
end