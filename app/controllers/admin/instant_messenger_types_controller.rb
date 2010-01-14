class Admin::InstantMessengerTypesController < AdminApplicationController
  inherit_resources
  before_filter :require_admin
end