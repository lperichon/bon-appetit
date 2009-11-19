class OrdersController < UserApplicationController
  # GET /orders
  # GET /orders.xml
  def index
    @orders = current_restaurant.orders.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orders }
    end
  end
end