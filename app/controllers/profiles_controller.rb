class ProfilesController < UserApplicationController
  def show
    @user = @parent = current_user
  end

  def update
    @user = current_user
    @user.attributes = params[:user]
    if @user.save
      flash[:notice] = t('profiles.update.success')
      redirect_to dashboard_path
    else
      render :action => :show
    end
  end
end