require 'test_helper'
require 'blueprints'

class OrderTest < ActiveSupport::TestCase
  context "any order" do
    setup { @order = Order.make }
    subject { @order }

    should_have_many :order_items

    should_belong_to :contact
    should_belong_to :address

    should_belong_to :restaurant
    should_validate_presence_of :restaurant

    should_allow_values_for(:discount, 0, 0.5, 1)
    should_not_allow_values_for(:discount, -0.2, 1.2, 'a', nil)
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

    context("after being closed") do
      setup { @order.closed = true; @order.save! }

      should("freeze the total") do
        assert_no_difference("@order.total") { @order.discount = 1 }
      end

      should "freeze the contact name" do
        assert @order.contact_name = @order.contact.name
      end

      should "freeze the subtotal" do
        assert_no_difference("@order.subtotal") { @order.discount = 1 }
      end
    end
  end
end