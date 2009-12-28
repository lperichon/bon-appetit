module OrdersHelper
  def order_status_label(order)
    order.closed? ? Order.human_attribute_name('closed') : Order.human_attribute_name('open')
  end
end
