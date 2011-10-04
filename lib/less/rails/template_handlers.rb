module Less  
  module Rails
    
    class LessTemplate < Tilt::LessTemplate
      
      def prepare
      end
      
      def evaluate(scope, locals, &block)
        @output ||= begin
          parser = ::Less::Parser.new less_parser_options(scope)
          engine = parser.parse(data)
          engine.to_css config_options(scope)
        end
      end
      
      protected
      
      def config_paths(scope)
        config_from_rails(scope)[:paths]
      end
      
      def config_options(scope)
        config_from_rails(scope)[:options] || {}
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
