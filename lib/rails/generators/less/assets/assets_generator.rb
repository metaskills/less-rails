require "rails/generators/named_base"

module Less
  module Generators
    class AssetsGenerator < ::Rails::Generators::NamedBase
      
      source_root File.expand_path '../templates', __FILE__

      def copy_less
        template 'stylesheet.css.less', File.join('app/assets/stylesheets', class_path, "#{file_name}.css.less")
      end
      
    end
  end
end
