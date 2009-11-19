class Admin::ProductsController < AdminApplicationController
  inherit_resources
  before_filter :require_admin
  belongs_to :restaurant, :polymorphic => true
end
