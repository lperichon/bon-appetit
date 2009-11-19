require 'test_helper'
require 'blueprints'

class ProductTypeTest < ActiveSupport::TestCase
  context "any product type" do
    setup { @product_type = ProductType.make }
    subject { @product_type }

    should_belong_to :restaurant
    should_have_many :products

    should_validate_presence_of :name
    should_validate_presence_of :restaurant
  end
end