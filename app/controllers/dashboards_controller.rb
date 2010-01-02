class DashboardsController < UserApplicationController

  def show
    @total_by_dow_hour_data = []
    (0..6).collect.reverse!.each do |dow|
      (0..23).each do |h|
        @total_by_dow_hour_data << current_restaurant.orders.this_month.by_dow(dow).by_hour(h).sum('total')
      end
    end
    #@total_by_dow_hour_data = [294, 300, 204, 255, 348, 383, 334, 217, 114, 33, 44, 26, 41, 39, 52, 17, 13, 2, 0, 2, 5, 6, 64, 153, 294, 313, 195, 280, 365, 392, 340, 184, 87, 35, 43, 55, 53, 79, 49, 19, 6, 1, 0, 1, 1, 10, 50, 181, 246, 246, 220, 249, 355, 373, 332, 233, 85, 54, 28, 33, 45, 72, 54, 28, 5, 5, 0, 1, 2, 3, 58, 167, 206, 245, 194, 207, 334, 290, 261, 160, 61, 28, 11, 26, 33, 46, 36, 5, 6, 0, 0, 0, 0, 0, 0, 9, 9, 10, 7, 10, 14, 3, 3, 7, 0, 3, 4, 4, 6, 28, 24, 3, 5, 0, 0, 0, 0, 0, 0, 4, 3, 4, 4, 3, 4, 13, 10, 7, 2, 3, 6, 1, 9, 33, 32, 6, 2, 1, 3, 0, 0, 4, 40, 128, 212, 263, 202, 248, 307, 306, 284, 222, 79, 39, 26, 33, 40, 61, 54, 17, 3, 0, 0, 0, 3, 7, 70, 199]

    sql = ActiveRecord::Base.connection();
    products_count = sql.execute("select p.name, count(oi.id) from products p, order_items oi, orders o where p.id = oi.product_id and oi.order_id = o.id and o.closed = 't' and o.generated_at >= '#{Date.today.beginning_of_month}' group by p.id")
    @products_pie_labels = products_count.collect {|d| d[0]}
    @products_pie_data = products_count.collect {|d| d[1]}
    #@products_pie_data = [55, 20, 13, 32, 5, 1, 2, 10]
  end

end