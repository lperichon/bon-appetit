require 'test_helper'
require 'blueprints'

class ContactsControllerTest < ActionController::TestCase
  context 'when user is not logged in' do
    setup { get :index }
    should_redirect_to("the login page") { login_url }
    should_set_the_flash_to 'You must be logged in to access this page'
  end

  context 'logged in as a normal user' do
    setup { login }

    context "get index" do
      setup { get :index }
      should_respond_with :success
      should_assign_to :contacts
    end

    context "get new" do
      setup { get :new }
      should_respond_with :success
    end

    context "create contact" do
      setup { post :create, :contact => Contact.plan }

      should_assign_to :contact
      should_redirect_to("contact's show page") { contact_path(assigns(:contact)) }
    end

    context "show contact" do
      setup { get :show, :id => Contact.create(:restaurant => @current_restaurant).id }

      should_respond_with :success
    end

    context "get edit" do
      setup { get :edit, :id => Contact.create(:restaurant => @current_restaurant).id }
      should_respond_with :success
    end

    context "update contact" do
      setup do
        contact = Contact.create(:restaurant => @current_restaurant)
        put :update, :id => contact.id, :contact => {:first_name => 'Bob'}
      end

      should_assign_to :contact
      should_redirect_to("contact's show page") { contact_path(assigns(:contact)) }
    end

    context "destroy contact" do
      setup do
        contact = Contact.create(:restaurant => @current_restaurant)
        delete :destroy, :id => contact.id
      end

      should_redirect_to("contact list") { contacts_path }
    end
  end
end
