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

      def depend_on(scope, data, base=File.dirname(scope.logical_path))
        import_paths = data.scan(IMPORT_SCANNER).flatten.compact.uniq
        for path in import_paths
          pathname = begin
                       scope.resolve(path)
                     rescue Sprockets::FileNotFound
                       # try relative path
                       path = File.join(base, path)
                       scope.resolve(path) rescue nil
                     end

          scope.depend_on(path) if pathname && pathname.to_s.ends_with?('.less')
          depend_on scope, File.read(pathname), File.dirname(path) if pathname
        end
        data
      end
      
    end
  end
end
