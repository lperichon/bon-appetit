class TablesController < UserApplicationController
  # the same as inheriting from InheritedResources::Base
  inherit_resources do
    actions :all, :except => :edit
  end

  respond_to :js, :only => :update

  def update
    if params[:id].present?
      update! do |success, failure|
        success.js { flash[:notice] = t('tables.update.success') }
      end
    elsif params[:tables_attributes].present?
      tables_attributes = params[:tables_attributes]
      tables_attributes.each do |table_id, table_attributes|
        table = current_restaurant.tables.find(table_id)
        table.attributes = table_attributes
        if table.save!
          respond_to do |method|
            method.js {}
            method.html do
              redirect_to :action => 'index'
              return true
            end
          end
        end
      end
    end
  end

  protected

  def begin_of_association_chain
    current_restaurant
  end
end
