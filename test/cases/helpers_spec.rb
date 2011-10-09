require 'spec_helper'

class HelpersSpec < Less::Rails::Spec
  
  before { dummy_config.less.compress = false }
  
  let(:helpers) { dummy_asset('helpers') }
  
  it 'parse asset paths' do
    line_for_helper('asset-path').must_equal  'asset-path: "/assets/rails.png";'
    line_for_helper('asset-url').must_equal   "asset-url: url(/assets/rails.png);"
    line_for_helper('image-path').must_equal  'image-path: "/assets/rails.png";'
    line_for_helper('image-url').must_equal   "image-url: url(/assets/rails.png);"
    line_for_helper('video-path').must_equal  'video-path: "/videos/rails.mp4";'
    line_for_helper('video-url').must_equal   "video-url: url(/videos/rails.mp4);"
    line_for_helper('audio-path').must_equal  'audio-path: "/audios/rails.mp3";'
    line_for_helper('audio-url').must_equal   "audio-url: url(/audios/rails.mp3);"
    line_for_helper('javascript-path').must_equal  'javascript-path: "/assets/rails.js";'
    line_for_helper('javascript-url').must_equal   "javascript-url: url(/assets/rails.js);"
    line_for_helper('stylesheet-path').must_equal  'stylesheet-path: "/assets/rails.css";'
    line_for_helper('stylesheet-url').must_equal   "stylesheet-url: url(/assets/rails.css);"
    line_for_helper('font-path').must_equal  'font-path: "/assets/rails.ttf";'
    line_for_helper('font-url').must_equal   "font-url: url(/assets/rails.ttf);"
  end
  
  it 'parses data urls ' do
    line = line_for_helper('asset-data-url')
    asset_data_url_regexp = %r{asset-data-url: url\((.*?)\)}
    line.must_match asset_data_url_regexp
    asset_data_url_match = line.match(asset_data_url_regexp)[1]
    asset_data_url_expected = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyRpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw%2FeHBhY2tldCBiZWdpbj0i77u%2FIiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8%2BIDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMC1jMDYxIDY0LjE0MDk0OSwgMjAxMC8xMi8wNy0xMDo1NzowMSAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENTNS4xIE1hY2ludG9zaCIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDpCNzY5NDE1QkQ2NkMxMUUwOUUzM0E5Q0E2RTgyQUExQiIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDpCNzY5NDE1Q0Q2NkMxMUUwOUUzM0E5Q0E2RTgyQUExQiI%2BIDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAuaWlkOkE3MzcyNTQ2RDY2QjExRTA5RTMzQTlDQTZFODJBQTFCIiBzdFJlZjpkb2N1bWVudElEPSJ4bXAuZGlkOkI3Njk0MTVBRDY2QzExRTA5RTMzQTlDQTZFODJBQTFCIi8%2BIDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY%2BIDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8%2B0HhJ9AAAABBJREFUeNpi%2BP%2F%2FPwNAgAEACPwC%2FtuiTRYAAAAASUVORK5CYII%3D"
    asset_data_url_match.must_equal asset_data_url_expected
  end


  private
  
  def line_for_helper(name)
    helpers.each_line.detect{ |line| line.include? name }.strip
  end

end
