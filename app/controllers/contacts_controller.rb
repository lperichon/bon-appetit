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
    @contacts = current_restaurant.contacts.phones_number_like("#{params[:val]}")
    if @contacts.empty?
      @contacts = current_restaurant.contacts.first_name_or_middle_name_or_last_name_like("#{params[:val]}")
    end

    @phones = []
    @contacts.each do |c|
      @phones += c.phones
    end
    respond_to do |format|
      format.json { render :json => @phones.collect {|p| {:id => p.owner.id, :text => "#{p.owner.name} - #{p.number}"}}.to_json, :layout => false}
    end
  end

  has_scope :starts_with

  protected

  def begin_of_association_chain
    current_restaurant
  end
end
