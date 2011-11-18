require 'spec_helper'

class BasicsSpec < Less::Rails::Spec
  
  it 'must render variables' do
    basics.must_match %r{#test-variable\{color:#4d926f;\}}
  end
  
  it 'must render mixins' do
    basics.must_match %r{#test-mixin span\{border:1px solid black;\}}
  end
  
  it 'must have a CSSCompressor' do
    Less::Rails::CssCompressor.new.compress('.class {width: 1+1}').must_equal '.class{width:2;}'
  end

  it 'must hook into less import so that imported paths are declared as sprocket dependencies of the source file' do
    skip 'will need to use the basics asset, then change the frameworks/bootstrap/mixins.less file, then render basics again'
  end

  protected
  
  def basics
    dummy_asset 'basics'
  end
  
end
