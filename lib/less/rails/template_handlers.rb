module Less  
  module Rails    
    class LessTemplate < Tilt::LessTemplate
      
      include Helpers
      
      TO_CSS_KEYS = [:compress, :optimization, :silent, :color]
      
      def prepare
      end
      
      def evaluate(scope, locals, &block)
        @output ||= begin
          Less.Parser['scope'] = scope
          parser = ::Less::Parser.new config_to_less_parser_options(scope)
          engine = parser.parse(data)
          engine.to_css config_to_css_options(scope)
        end
      end
      
      protected
      
      def config_to_less_parser_options(scope)
        paths = config_paths(scope) + scope.environment.paths
        {:filename => eval_file, :line => line, :paths => paths}
      end
      
      def config_to_css_options(scope)
        Hash[config_from_rails(scope).each.to_a].slice *TO_CSS_KEYS
      end
      
      def config_paths(scope)
        config_from_rails(scope)[:paths]
      end
      
      def config_from_rails(scope)
        scope.environment.context_class.less_config
      end
      
    end    
  end
end
