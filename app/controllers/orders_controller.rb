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

  def show
    @order = current_restaurant.orders.find(params[:id])
    @order_item = @order.order_items.new(:quantity => 1, :discount => 0)
  end

  def update
    @order = current_restaurant.orders.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        flash[:notice] = 'Order was successfully updated.'
        format.html { redirect_to orders_path }
        format.xml  { head :ok }
        format.js {}
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
        format.js {}
      end
    end
  end

  def new
    @order = current_restaurant.orders.new
  end

  def create
    @order = current_restaurant.orders.new(params[:order])

    respond_to do |format|
      if @order.save
        flash[:notice] = 'Order was successfully created.'
        format.html { redirect_to order_path @order }
        format.xml  { head :ok }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end
end