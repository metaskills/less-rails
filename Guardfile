guard 'minitest' do
  watch(%r|^test/(.*)_spec\.rb|)
  watch(%r|^lib/(.*)\.rb|)            { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r|^test/spec_helper\.rb|)    { "spec" }
end
