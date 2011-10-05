require 'spec_helper'

class BasicsSpec < Less::Rails::Spec
  
  let(:basics) { dummy_asset('basics') }
  
  it 'must render variables' do
    basics.must_match %r{#test-variable\{color:#4d926f;\}}
  end
  
  it 'must render mixins' do
    basics.must_match %r{#test-mixin span\{border:1px solid black;\}}
  end


end
