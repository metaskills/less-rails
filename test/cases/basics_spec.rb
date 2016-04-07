require 'spec_helper'

class BasicsSpec < Less::Rails::Spec
  
  it 'must render variables' do
    basics.must_match %r{#test-variable\{color:#4d926f\}}
  end
  
  it 'must render mixins' do
    basics.must_match %r{#test-mixin span\{border:1px solid black\}}
  end
  
  it 'must be able to use vendored less files' do
    basics.must_match %r{#test-vendored\{border-radius:10px\}}
  end
  
  describe 'less import dependency hooks' do
    
    it 'must update when imported file changes' do
      basics.must_match %r{#test-radiused\{border-radius:5px\}}, 'default is 5px'
      safely_edit(:mixins) do |data, asset|
        data.gsub! '5px', '10px'
        File.open(asset.pathname,'w') { |f| f.write(data) }
        basics.must_match %r{#test-radiused\{border-radius:10px\}}, 'mixins.less should be a sprockets context dependency'
      end
    end
    
    it 'must update when an imported file of another imported file changes' do
      basics.must_match %r{#test-variable-colored\{color:#424242\}}, 'default is #424242'
      safely_edit(:variables) do |data, asset|
        data.gsub! '424242', '666666'
        File.open(asset.pathname,'w') { |f| f.write(data) }
        basics.must_match %r{#test-variable-colored\{color:#666\}}, 'variables.less should be a sprockets context dependency'
      end
    end

    it 'must update when an imported file of another imported file changes, and that file is imported via a relative path' do
      basics.must_match %r{#test-variable-relative-path-colored}i, 'default is #BADA55'
      safely_edit(:variables_via_relative_path) do |data, asset|
        data.gsub! 'BADA55', 'BA73A2'
        File.open(asset.pathname,'w') { |f| f.write(data) }
        basics.must_match %r{#test-variable-relative-path-colored}i, 'variables_via_relative_path.less should be a sprockets context dependency'
      end
    end

  end

  describe 'relative path setting must be effective' do
    after do
      Rails.application.config.less.raw.clear
    end

    it 'must use relavite paths by default' do
      basics.must_match %r{body\{background-image:url\('i-have-no-imagination.png'\)\}}
    end

    it 'should respond to config modification' do
      Rails.application.config.less.raw.relativeUrls = false
      basics.must_match %r{body\{background-image:url\('../../i-have-no-imagination.png'\)\}}
    end
  end

  protected
  
  def basics
    dummy_asset 'basics'
  end
  
  def mixins_asset
    dummy_assets['frameworks/bootstrap/mixins.less']
  end
  
  def variables_asset
    dummy_assets['frameworks/bootstrap/variables.less']
  end

  def variables_via_relative_path_asset
    dummy_assets['frameworks/bootstrap/variables_via_relative_path.less']
  end

  def safely_edit(name)
    asset = send :"#{name}_asset"
    data = File.read(asset.pathname)
    begin
      yield data.dup, asset
    ensure
      File.open(asset.pathname,'w') { |f| f.write(data) }
    end
  end
end
