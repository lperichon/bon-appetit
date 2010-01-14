class Admin::InstantMessengerProtocolsController < AdminApplicationController
  inherit_resources
  before_filter :require_admin
end