require 'test_helper'
require 'blueprints'

class OrderItemTest < ActiveSupport::TestCase
  context "any order item" do
    setup { @order_item = make_order_item }

    subject { @order_item }

    should_belong_to :order
    should_belong_to :product

    should_validate_presence_of :order
    should_validate_presence_of :product

    should_allow_values_for(:discount, 0, 0.5, 1)
    should_not_allow_values_for(:discount, -0.2, 1.2, 'a', nil)

    should_allow_values_for(:quantity, 1, 2, 100)
    should_not_allow_values_for(:quantity, -1, 0, 'a', nil)

    should "calculate a subtotal" do
      assert @order_item.subtotal > 0
    end
  end

  context "A new order item" do
    setup do
      @order_item = OrderItem.new
      @order_item.valid?
    end

    should "default discount to 0" do
      assert_equal 0, @order_item.discount
    end

    should "default quantity to 1" do
      assert_equal 1, @order_item.quantity
    end
  end

  context "an order item" do
    setup {@order_item = make_order_item}

    context "after the order is closed" do
      setup { @order_item.order.closed = true; @order_item.order.save; }

      should "freeze the unit price" do
        #assert_no_difference("@order_item.unit_price") { @order_item.product.price = 10 }
      end
    end
  end
end