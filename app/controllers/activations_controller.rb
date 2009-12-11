class ActivationsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]

  def new
    @user = User.find_using_perishable_token(params[:activation_code], 1.week)
    unless @user
      flash[:notice] = t('activations.perishable_token_not_found')
      redirect_to login_url
      return
    end
    if @user.active?
      flash[:notice] = t('activations.already_active')
      redirect_to login_url
    end
  end

  def create
    @user = User.find(params[:id])

    if @user.active?
      flash[:notice] = t('activations.already_active')
      redirect_to login_url
    end

    if @user.activate!(params)
      @user.deliver_activation_confirmation!
      flash[:notice] = t('activations.create.success')
      redirect_to dashboard_path
    else
      render :action => :new
    end
  end
end
