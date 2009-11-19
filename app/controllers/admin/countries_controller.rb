class Admin::CountriesController < AdminApplicationController
  inherit_resources
  before_filter :require_admin
end