module Less  
  module Rails    
    class ImportProcessor < Tilt::Template
      
      IMPORT_SCANNER = /@import\s*['"]([^'"]+)['"]\s*;/.freeze
      
      def prepare
      end
      
      def depend_on context, data
        import_paths = data.scan(IMPORT_SCANNER).flatten.compact.uniq
        import_paths.each do |path|
          pathname = begin
                       context.resolve(path)
                     rescue Sprockets::FileNotFound
                       nil
                     end

          context.depend_on(path) if pathname && pathname.to_s.ends_with?('.less')

          if pathname
            data = File.read pathname
            depend_on context, data
          end
        end
      end

      def evaluate(context, locals, &block)
        depend_on context, data
        data
      end
      
    end
  end
end
