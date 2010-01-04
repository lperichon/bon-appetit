module ContactFieldActions
  def association_name
    self.field_name.pluralize
  end

  def field_name
    self.controller_class_name.chomp("Controller").singularize.underscore
  end

  def create
    @contact = current_restaurant.contacts.find(params[:contact_id])
    @field = @contact.send("#{self.association_name}").new(params[self.field_name.to_sym])

    if @phone.save
      flash[:notice] = t(self.association_name + '.create.notice')
      respond_to do |format|
        format.js {}
      end
    else
      render(:update) do |page|
        page.replace("#new_order_item", :partial => 'form', :locals => {:order_item => @order_item})
      end
    end
  end

  def update
    @contact = current_restaurant.contacts.find(params[:contact_id])
    @field = @contact.send("#{self.association_name}").find(params[:id])

    @field.attributes = params[self.field_name.to_sym]
    if @field.save
      flash[:notice] = t(self.association_name + '.update.notice')

      respond_to do |format|
        format.js {}
      end
    end
  end
end