require 'sprockets/railtie'

module Less  
  module Rails
    class Railtie < ::Rails::Railtie
      config.less = ActiveSupport::OrderedOptions.new
      config.less.paths = []
      config.less.compress = false
      config.less.raw = ActiveSupport::OrderedOptions.new
      config.app_generators.stylesheet_engine :less

      config.before_initialize do |app|
        require 'less'
        require 'less-rails'
        Sprockets::Engines #force autoloading
      end

      initializer 'less-rails.before.load_config_initializers', :before => :load_config_initializers, :group => :all do |app|
        sprockets_env = app.assets || Sprockets

        config.assets.configure do |env|
          if env.respond_to?(:register_transformer)
            env.register_mime_type 'text/less', extensions: ['.less'], charset: :css
            env.register_transformer 'text/less', 'text/css', ImportProcessor
          end

          if env.respond_to?(:register_engine)
            args = ['.less', LessTemplate]
            args << {mime_type: 'text/less', silence_deprecation: true } if env.method(:register_engine).arity.abs > 2
            env.register_engine(*args)
          end

          env.context_class.class_eval do
            class_attribute :less_config
            self.less_config = app.config.less
          end
        end
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

