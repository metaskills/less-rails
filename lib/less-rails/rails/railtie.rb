module Less  
  module Rails
    class Railtie < ::Rails::Railtie
      
      config.less = ActiveSupport::OrderedOptions.new
      
      config.less.load_paths = []
      
      config.before_initialize do |app|
        unless app.config.assets && app.config.assets.enabled
          raise "The less-rails plugin requires the asset pipeline to be enabled."
        end
        require 'less'
        Sprockets::Engines #force autoloading
        Sprockets.register_engine '.less', Less::Rails::LessTemplate
      end
      
    end
  end
end
