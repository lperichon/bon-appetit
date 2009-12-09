class ContactsController < UserApplicationController
  inherit_resources # the same as inheriting from InheritedResources::Base

  protected

  def begin_of_association_chain
    current_restaurant
  end
end
