module Less  
  module Rails    
    class ImportProcessor < Tilt::Template
      
      IMPORT_SCANNER = /@import\s*['"]([^'"]+)['"]\s*;/.freeze
      PATHNAME_FINDER = Proc.new { |scope, path| 
        begin
          scope.resolve(path)
        rescue Sprockets::FileNotFound
          nil
        end
      }
      
      def prepare
      end
      
      def evaluate(scope, locals, &block)
        depend_on scope, data
        data
      end

      def depend_on(scope, data, base=File.dirname(scope.logical_path))
        import_paths = data.scan(IMPORT_SCANNER).flatten.compact.uniq
        import_paths.each do |path|
          pathname = PATHNAME_FINDER.call(scope,path) || PATHNAME_FINDER.call(scope, File.join(base, path))
          scope.depend_on(pathname) if pathname && pathname.to_s.ends_with?('.less')
          depend_on scope, File.read(pathname), File.dirname(path) if pathname
        end
        data
      end

    end
  end
end
