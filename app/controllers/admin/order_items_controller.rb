class Admin::OrderItemsController < AdminApplicationController
  inherit_resources
  before_filter :require_admin
  nested_belongs_to :restaurant do
    belongs_to :order, :polymorphic => true
  end
end
