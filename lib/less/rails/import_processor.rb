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

      def depend_on(scope, data, base="")
        import_paths = data.scan(IMPORT_SCANNER).flatten.compact.uniq
        import_paths.each do |path|
          tried_relative_path = false
          pathname = begin
                       scope.resolve(path)
                     rescue Sprockets::FileNotFound
                       if !tried_relative_path
                         path = File.join(base, path)
                         tried_relative_path = true
                         retry
                       end
                       nil
                     end
          scope.depend_on(path) if pathname && pathname.to_s.ends_with?('.less')
          depend_on scope, File.read(pathname), File.dirname(path) if File.exists?(pathname)
        end
        data
      end
      
    end
  end
end
