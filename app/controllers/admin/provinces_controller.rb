class Admin::ProvincesController < AdminApplicationController
  inherit_resources
  before_filter :require_admin
  belongs_to :country, :polymorphic => true
end