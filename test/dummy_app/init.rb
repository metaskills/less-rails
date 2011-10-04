require 'action_controller/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'

module Dummy
  class Application < ::Rails::Application

    config.root = File.join __FILE__, '..'
    config.assets.enabled = true
    

  end
end

Dummy::Application.initialize!
