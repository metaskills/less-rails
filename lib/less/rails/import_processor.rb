module Less  
  module Rails    
    class ImportProcessor < Tilt::Template
      
      IMPORT_SCANNER = /@import\s*['"]([^'"]+)['"]\s*;/.freeze
      
      def prepare
      end
      
      def evaluate(scope, locals, &block)
        depend_on scope, data
        data
      end
      
      def depend_on(scope, data)
        import_paths = data.scan(IMPORT_SCANNER).flatten.compact.uniq
        import_paths.each do |path|
          asset = scope.environment[path]
          if asset && asset.pathname.to_s.ends_with?('.less')
            scope.depend_on_asset(asset.pathname)
            d = File.read asset.pathname
            depend_on scope, d
          end
        end
        data
      end
      
    end
  end
end
