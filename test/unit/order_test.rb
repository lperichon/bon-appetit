require 'test_helper'
require 'blueprints'

class OrderTest < ActiveSupport::TestCase
  context "any order" do
    setup { @order = Order.make }
    subject { @order }

    should_have_many :order_items

    should_belong_to :restaurant
    should_validate_presence_of :restaurant

    should_allow_values_for(:discount, 0, 0.5, 1, nil)
    should_not_allow_values_for(:discount, -0.2, 1.2, 'a')
  end

  context "a new order" do
    setup do
      @order = Order.new
      @order.valid?
    end

    subject { @order }

    should "default discount to 0" do
      assert_equal 0, @order.discount
    end

    should "be open" do
      assert !@order.closed?
    end
  end
  
  context "an order with items" do
    setup { @order = make_order_with_items }

    should("calculate a total") do
      assert @order.total >= 0
    end
  end
end