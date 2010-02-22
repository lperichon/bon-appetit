class SignupsController < ApplicationController
  before_filter :require_user, :except => :create

  def create
    @user = User.new

    if @user.signup!(params)
      @user.deliver_activation_instructions!
      flash[:notice] = t('signups.create.success')
      redirect_to root_path
    else
      rediret_to root_path
    end
  end
  
end
