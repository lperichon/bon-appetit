class Admin::PhoneTypesController < AdminApplicationController
  inherit_resources
  before_filter :require_admin
end