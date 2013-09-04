require 'spec_helper'
require 'rails/generators/less/assets/assets_generator'
require 'rails/generators/less/scaffold/scaffold_generator'

class AssetsGeneratorSpec < Less::Rails::GeneratorSpec
  
  it 'should generate a posts.css.less file' do
    run_generator ['posts']
    assert_file 'app/assets/stylesheets/posts.css.less' do |contents|
      contents.must_match %r{Place all the styles related to the posts controller here}
      contents.must_match %r{You can use Less here}
    end
  end
  
end

class ScaffoldGeneratorSpec < Less::Rails::GeneratorSpec
  
  it 'should parse and copy the scaffold to a less file' do
    run_generator ['posts']
    assert_file 'app/assets/stylesheets/scaffolds.css.less' do |contents|
      contents.must_match %r{background-color: #fff}
    end
  end
  
end

