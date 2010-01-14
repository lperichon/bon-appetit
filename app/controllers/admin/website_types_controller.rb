class Admin::WebsiteTypesController < AdminApplicationController
  inherit_resources
  before_filter :require_admin
end