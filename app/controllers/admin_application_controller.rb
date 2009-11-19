# Filters added to this controller apply to all controllers in the admin namespace.
# Likewise, all the methods added will be available for all controllers in the admin namespace.

class AdminApplicationController < ApplicationController
  layout 'admin'
end