require "less"
require "rails/generators/named_base"
require "rails/generators/rails/scaffold/scaffold_generator"

module Less
  module Generators
    class ScaffoldGenerator < ::Rails::Generators::NamedBase
      
      def copy_stylesheet
        file = File.join ::Rails::Generators::ScaffoldGenerator.source_root, 'scaffold.css'
        css = Less::Parser.new.parse(File.read(file)).to_css
        create_file "app/assets/stylesheets/scaffolds.css.less", css
      end
      
    end
  end
end
