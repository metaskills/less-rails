guard 'minitest' do
  watch(%r|^lib/less/rails/(.*)\.rb|)   { |m| "test/cases/#{m[1]}_spec.rb" }
  # watch(%r|^lib/less/rails\.rb|)      { "test/cases" }
  # watch(%r|^test/dummy_app/.*|)       { "test/cases" }
  watch(%r|^test/spec_helper\.rb|)      { "test/cases" }
  watch(%r|^test/cases/(.*)_spec\.rb|)
end
