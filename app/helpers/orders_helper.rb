module OrdersHelper
  def order_status_label(order)
    order.closed? ? 'closed' : 'open'
  end
end
