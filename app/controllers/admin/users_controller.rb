class Admin::UsersController < InheritedResources::Base
  layout 'admin'
  before_filter :require_admin
  belongs_to :restaurant, :polymorphic => true

  actions :index, :show, :edit, :update, :destroy, :new

  def create
    @user = User.new(params[:user])
    @user.admin = params[:user][:admin]
    @restaurant = Restaurant.find(params[:restaurant_id]) if params[:restaurant_id]

    if @user.signup!(params)
      @user.deliver_invited_activation_instructions!
      if @restaurant
        @restaurant.users << @user
        @restaurant.save
        redirect_url = admin_restaurant_users_url(@restaurant)
      else
        redirect_url = admin_users_url()
      end

      flash[:notice] = "The user has been created. An email has been sent with activation instructions."
      redirect_to redirect_url
    else
      render :action => :new
    end
  end
end
