class OrderItemsController < UserApplicationController
  def create
    @order = current_restaurant.orders.find(params[:order_id])
    @order_item = @order.order_items.new(params[:order_item])

    if @order_item.save
      respond_to do |format|
        format.js {}
      end
    else
      render(:update) do |page|
        page.replace("#new_order_item", :partial => 'form', :locals => {:order_item => @order_item})
      end
    end
  end
end