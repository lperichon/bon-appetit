class ContactsController < UserApplicationController
  # the same as inheriting from InheritedResources::Base
  inherit_resources do
    actions :all, :except => [:index, :edit]
  end

  respond_to :js, :only => :update

  def index
    @search = current_restaurant.contacts.search(params[:search])
    if params[:search]
      @contacts = @search.all
    else
      @contacts = apply_scopes(current_restaurant.contacts).all
    end
  end

  def update
    update! do |success, failure|
      success.js { flash[:notice] = t('contacts.update.success') }
    end
  end

  def autocomplete
    @contacts = current_restaurant.contacts.first_name_or_middle_name_or_last_name_like("#{params[:val]}")
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
