require 'less'
require 'grease'
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
        sprockets_env = app.assets || Sprockets
        if sprockets_env.respond_to?(:register_engine)
          args = ['.less', Grease.apply(LessTemplate)]
          args << { mime_type: 'text/less', silence_deprecation: true } if Sprockets::VERSION.start_with?("3")
          sprockets_env.register_engine(*args)
        end

        if sprockets_env.respond_to?(:register_transformer)
          sprockets_env.register_mime_type 'text/less', extensions: ['.less', '.less.erb'], charset: :css
          sprockets_env.register_transformer 'text/less', 'text/css', Grease.apply(LessTemplate)
        end
      end

      initializer 'less-rails.before.load_config_initializers', :before => :load_config_initializers, :group => :all do |app|
        sprockets_env = app.assets || Sprockets
        sprockets_env.register_preprocessor 'text/css', Grease.apply(ImportProcessor)

        config.assets.configure do |env|
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

