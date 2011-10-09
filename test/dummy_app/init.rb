require 'sprockets/railtie'
require 'action_controller/railtie'
require 'action_view/railtie'
require 'action_view/base'
require 'action_controller/base'

module Dummy
  class Application < ::Rails::Application

    config.root = File.join __FILE__, '..'
    config.assets.enabled = true
    config.active_support.deprecation = :stderr
    
  end
end

Dummy::Application.initialize!
