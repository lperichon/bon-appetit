class OrderItemsController < UserApplicationController
  def create
    @order = current_restaurant.orders.find(params[:order_id])
    @order_item = @order.order_items.new(params[:order_item])
    @order_item.save

    respond_to do |format|
      format.js {}
    end
  end
end