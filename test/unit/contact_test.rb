require 'test_helper'
require 'blueprints'

class ContactTest < ActiveSupport::TestCase
  context "A Contact instance" do
    setup do
      @contact = make_contact
    end

    subject { @contact }

    should_belong_to :restaurant
  end
end

