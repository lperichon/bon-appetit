class ContactsController < UserApplicationController
  # the same as inheriting from InheritedResources::Base
  inherit_resources do
    actions :all, :except => :index
  end

  def index
    @contacts = apply_scopes(current_restaurant.contacts).all
  end

  def autocomplete
    @contacts = current_restaurant.contacts.find(:all, :conditions => ['first_name LIKE ?', "%#{params[:q]}%"])
    respond_to do |format|
      format.json { render :json => @contacts.collect {|c| {:id => c.id, :text => c.name}}.to_json, :layout => false}
    end
  end

  has_scope :starts_with

  protected

  def begin_of_association_chain
    current_restaurant
  end
end
