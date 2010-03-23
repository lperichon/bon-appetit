require 'test_helper'
require 'blueprints'

class ContactTest < ActiveSupport::TestCase
  context "A Contact instance" do
    setup do
      @contact = make_contact
    end

    subject { @contact }

    should_belong_to :restaurant

    should "prepare a map" do
      @contact.map.is_a? GMap
    end
  end

  context "Searching by start letter 'b' " do
    setup do
      restaurant = make_restaurant
      @bart = Contact.make(:restaurant => restaurant, :first_name => 'Bart')
      @homer =Contact.make(:restaurant => restaurant, :first_name => 'Homer')
      @contacts = Contact.starts_with 'b'
    end
    
    subject {@contacts}

    should "not find Homer" do
      assert !@contacts.include?(@homer) 
    end

    should "find Bart" do
      assert @contacts.include?(@bart)
    end
  end
end

