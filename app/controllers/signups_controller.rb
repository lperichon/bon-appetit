class SignupsController < ApplicationController
  before_filter :require_user, :except => [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new

    if @user.signup!(params)
      @user.deliver_activation_instructions!
      flash[:notice] = t('signups.create.success')
      redirect_to login_url
    else
      render :action => :new
    end
  end
  
end
