module Less  
  module Rails
    
    class LessTemplate < Tilt::LessTemplate
      
      def prepare
        parser  = ::Less::Parser.new :filename => eval_file, :line => line, :paths => ::Rails.application.config.less.load_paths
        @engine = parser.parse(data)
      end
      
    end
    
  end
end
