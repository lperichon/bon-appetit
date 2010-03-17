class Admin::IdentificationTypesController < AdminApplicationController
  inherit_resources
  before_filter :require_admin
end