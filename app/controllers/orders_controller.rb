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
  end

  def edit
    @order = current_restaurant.orders.find(params[:id])
  end

  def update
    @order = current_restaurant.orders.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        flash[:notice] = 'Order was successfully updated.'
        format.html { redirect_to orders_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
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
        format.html { redirect_to edit_order_path @order }
        format.xml  { head :ok }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end
end