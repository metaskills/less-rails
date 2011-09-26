require 'tilt'
require 'sprockets'

module Less  
  module Rails
    
    class LessTemplate < Tilt::LessTemplate
      
      def prepare
      end
      
      def evaluate(scope, locals, &block)
        @output ||= begin
          parser = ::Less::Parser.new less_parser_options(scope)
          engine = parser.parse(data)
          engine.to_css
        end
      end
      
      protected
      
      def less_options_from_rails(scope)
        scope.environment.context_class.less_config
      end

      def less_parser_options(scope)
        less_options = less_options_from_rails(scope)
        paths = less_options[:paths] + scope.environment.paths
        {:filename => eval_file, :line => line, :paths => paths}
      end
      
    end
    
  end
end
