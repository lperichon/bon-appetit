class ProfilesController < UserApplicationController
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.attributes = params[:user]
    if @user.save
      flash[:notice] = t('profiles.update.success')
      redirect_to dashboard_path
    else
      render :action => :edit
    end
  end
end