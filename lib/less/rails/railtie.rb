module Less  
  module Rails
    class Railtie < ::Rails::Railtie
      
      module LessContext
        attr_accessor :less_config
      end
      
      config.less = ActiveSupport::OrderedOptions.new
      config.less.paths = []
      config.less.compress = false
      config.app_generators.stylesheet_engine :less
      
      config.before_initialize do |app|
        require 'less'
        require 'less-rails'
        Sprockets::Engines #force autoloading
        Sprockets.register_engine '.less', Less::Rails::LessTemplate
      end
      
      initializer 'less-rails.before.load_config_initializers', :before => :load_config_initializers, :group => :all do |app|
        raise 'The less-rails plugin requires the asset pipeline to be enabled.' unless app.config.assets.enabled
        app.assets.register_preprocessor 'text/css', ImportProcessor
      end
      
      initializer 'less-rails.after.load_config_initializers', :after => :load_config_initializers, :group => :all do |app|
        app.assets.context_class.extend(LessContext)
        app.assets.context_class.less_config = app.config.less
      end
      
      initializer 'less-rails.after.append_assets_path', :after => :append_assets_path, :group => :all do |app|
        assets_stylesheet_paths = app.config.assets.paths.select { |p| p && p.to_s.ends_with?('stylesheets') }
        app.config.less.paths.unshift(*assets_stylesheet_paths)
      end
      
      initializer 'less-rails.setup_compression', :group => :all do |app|
        config.less.compress = app.config.assets.compress
      end
      
    end
  end
end

