module Less  
  module Rails
    
    class LessTemplate < Tilt::LessTemplate
      
      TO_CSS_KEYS = [:compress, :optimization, :silent, :color]
      
      def prepare
      end
      
      def evaluate(scope, locals, &block)
        @output ||= begin
          parser = ::Less::Parser.new less_parser_options(scope)
          engine = parser.parse(data)
          engine.to_css config_to_css_options(scope)
        end
      end
      
      protected
      
      def config_paths(scope)
        config_from_rails(scope)[:paths]
      end
      
      def config_to_css_options(scope)
        Hash[config_from_rails(scope).each.to_a].slice *TO_CSS_KEYS
      end
      
      def config_from_rails(scope)
        scope.environment.context_class.less_config
      end

      def less_parser_options(scope)
        paths = config_paths(scope) + scope.environment.paths
        {:filename => eval_file, :line => line, :paths => paths}
      end
      
    end
    
  end
end
