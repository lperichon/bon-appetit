require 'locales_switch'

ActionController::Base.send :include, LocalesSwitch::Controller
ActionView::Base.send       :include, LocalesSwitch::Helper