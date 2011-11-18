require 'spec_helper'

class BasicsSpec < Less::Rails::Spec
  
  it 'must render variables' do
    basics.must_match %r{#test-variable\{color:#4d926f;\}}
  end
  
  it 'must render mixins' do
    basics.must_match %r{#test-mixin span\{border:1px solid black;\}}
  end

  it 'must hook into less import so that imported paths are declared as sprocket dependencies of the source file' do
    basics.must_match %r{#test-radiused\{border-radius:5px;\}}, 'default is 5px'
    safely_edit_mixins do |d|
      d.gsub! '5px', '10px'
      File.open(mixins_asset.pathname,'w') { |f| f.write(d) }
      basics.must_match %r{#test-radiused\{border-radius:10px;\}}, 'mixins.less should be a sprockets context dependency'
    end
  end

  protected
  
  def basics
    dummy_asset 'basics'
  end
  
  def mixins_asset
    dummy_assets['frameworks/bootstrap/mixins.less']
  end
  
  def safely_edit_mixins
    data = File.read(mixins_asset.pathname)
    begin
      yield data.dup
    ensure
      File.open(mixins_asset.pathname,'w') { |f| f.write(data) }
    end
  end
end
