module Less
  
  def self.less
    @less
  end
  
  def self.register_rails_helper(name, &block)
    tree = @loader.require('less/tree')
    tree.functions[name] = lambda do |*args|
      # args: (this, node) v8 >= 0.10, otherwise (node)
      raise ArgumentError, "missing node" if args.empty?
      tree[:Anonymous].new block.call(tree, args.last)
    end
  end
  
  module Rails
    module Helpers
      
      extend ActiveSupport::Concern
      
      included do
        Less.register_rails_helper('asset-path')      { |tree, cxt| asset_path       unquote(cxt.toCSS()) }
        Less.register_rails_helper('asset-url')       { |tree, cxt| asset_url        unquote(cxt.toCSS()) }
        Less.register_rails_helper('image-path')      { |tree, cxt| image_path       unquote(cxt.toCSS()) }
        Less.register_rails_helper('image-url')       { |tree, cxt| image_url        unquote(cxt.toCSS()) }
        Less.register_rails_helper('video-path')      { |tree, cxt| video_path       unquote(cxt.toCSS()) }
        Less.register_rails_helper('video-url')       { |tree, cxt| video_url        unquote(cxt.toCSS()) }
        Less.register_rails_helper('audio-path')      { |tree, cxt| audio_path       unquote(cxt.toCSS()) }
        Less.register_rails_helper('audio-url')       { |tree, cxt| audio_url        unquote(cxt.toCSS()) }
        Less.register_rails_helper('javascript-path') { |tree, cxt| javascript_path  unquote(cxt.toCSS()) }
        Less.register_rails_helper('javascript-url')  { |tree, cxt| javascript_url   unquote(cxt.toCSS()) }
        Less.register_rails_helper('stylesheet-path') { |tree, cxt| stylesheet_path  unquote(cxt.toCSS()) }
        Less.register_rails_helper('stylesheet-url')  { |tree, cxt| stylesheet_url   unquote(cxt.toCSS()) }
        Less.register_rails_helper('font-path')       { |tree, cxt| font_path        unquote(cxt.toCSS()) }
        Less.register_rails_helper('font-url')        { |tree, cxt| font_url         unquote(cxt.toCSS()) }
        Less.register_rails_helper('asset-data-url')  { |tree, cxt| asset_data_url   unquote(cxt.toCSS()) }
      end
      
      module ClassMethods
        
        def asset_data_url(path)
          "url(#{scope.asset_data_uri(path)})"
        end
        
        def asset_path(asset)
          public_path(asset).inspect
        end
        
        def asset_url(asset)
          "url(#{public_path(asset)})"
        end
        
        def image_path(img)
          scope.image_path(img).inspect
        end

        def image_url(img)
          "url(#{scope.image_path(img)})"
        end

        def video_path(video)
          scope.video_path(video).inspect
        end
        
        def video_url(video)
          "url(#{scope.video_path(video)})"
        end
        
        def audio_path(audio)
          scope.audio_path(audio).inspect
        end
        
        def audio_url(audio)
          "url(#{scope.audio_path(audio)})"
        end
        
        def javascript_path(javascript)
          scope.javascript_path(javascript).inspect
        end
        
        def javascript_url(javascript)
          "url(#{scope.javascript_path(javascript)})"
        end
        
        def stylesheet_path(stylesheet)
          scope.stylesheet_path(stylesheet).inspect
        end
        
        def stylesheet_url(stylesheet)
          "url(#{scope.stylesheet_path(stylesheet)})"
        end

        def font_path(font)
          if scope.respond_to?(:font_path)
            scope.font_path(font).inspect
          else
            asset_path(font)
          end
        end
        
        def font_url(font)
          if scope.respond_to?(:font_path)
            "url(#{scope.font_path(font)})"
          else
            asset_url(font)
          end
        end
        
        private
        
        def scope
          Less.Parser['scope']
        end
        
        def public_path(asset)
          if scope.respond_to?(:asset_paths)
            scope.asset_paths.compute_public_path asset, ::Rails.application.config.assets.prefix
          else
            scope.path_to_asset(asset)
          end
        end
        
        def context_asset_data_uri(path)
          
        end
        
        def unquote(str)
          s = str.to_s.strip
          s =~ /^['"](.*?)['"]$/ ? $1 : s
        end
        
      end
      
    end
  end
end

