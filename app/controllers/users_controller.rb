class UsersController < UserApplicationController
  helper ContactableHelper
  
  # the same as inheriting from InheritedResources::Base
  inherit_resources do
    actions :all, :except => [:create, :edit]
  end

  respond_to :js, :only => :update

  def update
    update! do |success, failure|
      session[:locale] = @user.locale
      success.js { flash[:notice] = t('users.update.success') }
    end
  end

  # POST /users
  # POST /users.xml
  def create
    @user = current_restaurant.users.new(params[:user])

    respond_to do |format|
      if @user.signup!(params)
        @user.deliver_invited_activation_instructions!(current_restaurant)
        current_restaurant.users << @user
        current_restaurant.save
        flash[:notice] = t('users.create.success')
        format.html { redirect_to(@user) }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  protected

  def destroy_resource(resource)
    resource.restaurants.delete(current_restaurant)
    if resource.restaurants.empty?
      resource.destroy
    else
      resource.save
    end
  end

  def begin_of_association_chain
    current_restaurant
  end

end
