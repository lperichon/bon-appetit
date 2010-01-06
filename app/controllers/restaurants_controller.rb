class RestaurantsController < UserApplicationController
  # GET /restaurant/edit
  def show
    @restaurant = current_restaurant
  end

  # PUT /restaurant
  # PUT /restaurant.xml
  def update
    @restaurant = current_restaurant

    respond_to do |format|
      if @restaurant.update_attributes(params[:restaurant])
        flash[:notice] = t('restaurants.update.success')
        format.js { } # default update.js.rjs
      else
#        format.html { render :action => "show" }
#        format.xml  { render :xml => @restaurant.errors, :status => :unprocessable_entity }
      end
    end
  end
end
