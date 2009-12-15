class ContactsController < UserApplicationController
  inherit_resources # the same as inheriting from InheritedResources::Base

  def autocomplete
    @contacts = current_restaurant.contacts.find(:all, :conditions => ['first_name LIKE ?', "%#{params[:q]}%"])
    respond_to do |format|
      format.json { render :json => @contacts.collect {|c| {:id => c.id, :text => c.name}}.to_json, :layout => false}
    end
  end

  protected

  def begin_of_association_chain
    current_restaurant
  end
end
