class TablesController < UserApplicationController
  # the same as inheriting from InheritedResources::Base
  inherit_resources do
    actions :all, :except => :edit
  end

  respond_to :js, :only => :update

  def update
    update! do |success, failure|
      success.js { flash[:notice] = t('tables.update.success') }
    end
  end

  protected

  def begin_of_association_chain
    current_restaurant
  end
end
