module Less  
  module Rails
    class CssCompressor
      
      def compress(css)
        ::Less::Parser.new.parse(css).to_css(:compress => true).strip
      end
      
    end 
  end
end
