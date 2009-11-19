class Admin::CitiesController < AdminApplicationController
  inherit_resources
  before_filter :require_admin
  nested_belongs_to :country do
    belongs_to :province, :polymorphic => true
  end
end