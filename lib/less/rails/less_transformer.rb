module Less
  module Rails
    class LessTransformer
      include Helpers

      TO_CSS_KEYS = [:compress, :optimization, :silent, :color]

      def initialize(filename, &block)
        @filename = filename
        @source   = block.call
      end

      def render(scope, locals)
        self.class.evaluate(@filename, @source, scope)
      end

      def self.evaluate(filename, source, scope)
        Less.Parser['scope'] = scope
        parser = ::Less::Parser.new config_to_less_parser_options(filename, scope)
        engine = parser.parse(source)
        engine.to_css config_to_css_options(scope)
      end

      def self.call(input)
        filename = input[:filename]
        source   = input[:data]
        scope  = input[:environment].context_class.new(input)

        result = evaluate(filename, source, scope)
        scope.metadata.merge(data: result)
      end

      def self.default_mime_type
        'text/css'
      end

      protected

      def self.config_to_less_parser_options(filename, scope)
        paths = config_paths(scope) + scope.environment.paths
        local_path = scope.pathname.dirname
        paths += [local_path] unless paths.include? local_path
        {:filename => filename, :paths => paths, :dumpLineNumbers => config_from_rails(scope).line_numbers}.merge(config_raw(scope))
      end

      def self.config_to_css_options(scope)
        Hash[config_from_rails(scope).each.to_a].slice *TO_CSS_KEYS
      end

      def self.config_paths(scope)
        config_from_rails(scope)[:paths]
      end

      def self.config_raw(scope)
        config_from_rails(scope)[:raw]
      end

      def self.config_from_rails(scope)
        scope.environment.context_class.less_config
      end

    end
  end
end
