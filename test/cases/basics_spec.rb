require 'test_helper'

class BasicsSpec < Less::Rails::Spec
  
  let(:basics) { dummy_asset('basics') }
  
  it 'must render variables' do
    basics.must_match %r{#test-variable\{color:#4d926f;\}}
  end

end
