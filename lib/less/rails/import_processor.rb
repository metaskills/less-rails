module Less  
  module Rails    
    class ImportProcessor < Tilt::Template
      
      IMPORT_SCANNER = /@import\s*['"]([^'"]+)['"]\s*;/.freeze
      
      def prepare
      end
      
      def evaluate(context, locals, &block)
        import_paths = data.scan(IMPORT_SCANNER).flatten.compact.uniq
        import_paths.each do |path|
          asset = context.environment[path]
          if asset && asset.pathname.to_s.ends_with?('.less')
            context.depend_on_asset(asset.pathname)
          end
        end
        data
      end
      
    end
  end
end
