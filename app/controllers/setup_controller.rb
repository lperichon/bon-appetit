class SetupController < UserApplicationController
  skip_before_filter :setup
  
  def index
    wizard(:index, :index, :your_restaurant)
  end

  def your_restaurant
    @restaurant = current_user.restaurants.first || Restaurant.new
    wizard(:your_restaurant, :index, :your_restaurant)
  end

  def save_restaurant
    @restaurant = current_user.restaurants.first || Restaurant.new
    @restaurant.attributes = params[:restaurant]
    @restaurant.manager = current_user
    if @restaurant.save
      current_user.restaurants << @restaurant
      current_user.save
      redirect_to :action => :finish
    else
      render :your_restaurant
    end
  end

  def finish
    wizard(:finish, :your_restaurant, :finish)
  end



end