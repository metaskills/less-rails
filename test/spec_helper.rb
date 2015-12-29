require 'bundler' ; Bundler.require :development, :test
require 'less-rails'
require 'minitest/autorun'
require 'dummy_app/init'
require 'rails/generators'
require 'fileutils'

module Less
  module Rails
    class Spec < MiniTest::Spec
      
      include FileUtils
      
      class << self
        
        def dummy_app
          Dummy::Application
        end

        def dummy_tmp
          "#{dummy_app.root}/tmp"
        end
        
      end
      
      before do
        prepare_cache_dir
        reset_config_options
        reset_caches
      end
      
      protected
      
      delegate :dummy_app, :dummy_tmp, :to => :'self.class'

      def dummy_config
        dummy_app.config
      end
      
      def dummy_assets
        dummy_app.assets
      end
      
      def dummy_asset(name)
        dummy_assets[name].to_s.strip
      end
      
      def reset_config_options
        dummy_config.less.compress = true
      end
      
      def reset_caches
        version = SecureRandom.hex(32)
        dummy_config.assets.version = version
        dummy_assets.version = version
        cache = dummy_assets.cache
        cache.respond_to?(:clear) ? cache.clear : rm_rf("#{dummy_tmp}/cache/assets")
      end
      
      def prepare_cache_dir
        mkdir_p "#{dummy_tmp}/cache/assets"
      end
      
    end
    
    # Heavily inspired by Rails::Generators::TestCase.
    class GeneratorSpec < Spec
      
      class_attribute :destination_root, :current_path, :generator_class, :default_arguments
      delegate        :destination_root, :current_path, :generator_class, :default_arguments, :to => :'self.class'
      
      self.current_path      = File.expand_path(Dir.pwd)
      self.default_arguments = []
      self.destination_root  = "#{dummy_tmp}/destination_root"
      
      before { ensure_current_path ; prepare_destination ; no_color! ; setup_generator_class }
      after  { remove_destination ; ensure_current_path }
      
      protected
      
      def no_color!
        Thor::Base.shell = Thor::Shell::Basic
      end
      
      def ensure_current_path
        cd current_path
      end
      
      def prepare_destination
        remove_destination
        mkdir_p destination_root
      end
      
      def remove_destination
        rm_rf destination_root
      end
      
      def setup_generator_class
        self.class.generator_class = Less::Generators.const_get(self.class.name.sub(/Spec$/, ''))
      end
      
      def run_generator(args=default_arguments, config={})
        capture(:stdout) { generator_class.start(args, config.reverse_merge(:destination_root => destination_root)) }
      end

      def generator(args=default_arguments, options={}, config={})
        @generator ||= generator_class.new(args, options, config.reverse_merge(:destination_root => destination_root))
      end
      
      def assert_file(relative, *contents)
        absolute = File.expand_path(relative, destination_root)
        assert File.exists?(absolute), "Expected file #{relative.inspect} to exist, but does not"
        read = File.read(absolute) if block_given? || !contents.empty?
        yield read if block_given?
        contents.each do |content|
          case content
            when String
              assert_equal content, read
            when Regexp
              assert_match content, read
          end
        end
      end
      alias :assert_directory :assert_file
      
    end
    
  end
end

