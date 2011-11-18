require 'spec_helper'

class RailtieSpec < Less::Rails::Spec
  
  describe 'config' do
    
    it 'must have a less ordered hash' do
      dummy_config.less.must_be_instance_of ActiveSupport::OrderedOptions
    end
    
    it 'must have an empty array for paths' do
      dummy_config.less.paths.must_equal Array.new
    end
    
    it 'must have an options hash passed down to the #to_css method' do
      basic_compressed_match = /#test-variable\{color:#4d926f;\}/
      dummy_config.less.compress = true
      dummy_asset('basics').must_match basic_compressed_match
      reset_caches
      dummy_config.less.compress = false
      dummy_asset('basics').wont_match basic_compressed_match
    end
  
  end
  
  describe 'initialization' do
    
    it 'must register our template engine' do
      dummy_assets.engines['.less'].must_equal Less::Rails::LessTemplate
    end
    
    it 'must extend the context class with our config' do
      dummy_assets.context_class.must_respond_to :less_config
      dummy_assets.context_class.less_config.must_equal dummy_config.less
    end
    
    it 'must register our import pre processor' do
      dummy_assets.preprocessors['text/css'].must_include Less::Rails::ImportProcessor
    end
    
  end


end
