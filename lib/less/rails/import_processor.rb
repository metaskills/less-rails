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
          pathname = begin
                       scope.resolve(path)
                     rescue Sprockets::FileNotFound
                       nil
                     end
          scope.depend_on(path) if pathname && pathname.to_s.ends_with?('.less')
          depend_on scope, File.read(pathname) if pathname
        end
        data
      end
      
    end
  end
end
