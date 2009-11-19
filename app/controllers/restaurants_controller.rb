class RestaurantsController < UserApplicationController
  # GET /restaurant/edit
  def edit
    @restaurant = current_restaurant
  end

  # PUT /restaurant
  # PUT /restaurant.xml
  def update
    @restaurant = current_restaurant

    respond_to do |format|
      if @restaurant.update_attributes(params[:restaurant])
        flash[:notice] = 'Restaurant was successfully updated.'
        format.html { redirect_to dashboard_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @restaurant.errors, :status => :unprocessable_entity }
      end
    end
  end
end
