class Admin::TableTypesController < AdminApplicationController
  inherit_resources
  before_filter :require_admin
end