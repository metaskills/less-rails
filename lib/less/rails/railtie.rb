module Less  
  module Rails
    class Railtie < ::Rails::Railtie
      
      module LessContext
        attr_accessor :less_config
      end
      
      config.less = ActiveSupport::OrderedOptions.new
      
      config.less.paths = []
      config.less.compress = false
      
      initializer 'less-rails.before-setup', :group => :assets, :after => :bootstrap_hook do |app|
        unless app.config.assets && app.config.assets.enabled
          raise "The less-rails plugin requires the asset pipeline to be enabled."
        end
        require 'less'
        Sprockets::Engines #force autoloading
        Sprockets.register_engine '.less', Less::Rails::LessTemplate
      end

      initializer 'less-rails.after-setup', :group => :assets, :after => :finisher_hook do |app|
        app.assets.context_class.extend(LessContext)
        app.assets.context_class.less_config = app.config.less
      end
      
    end
  end
end
