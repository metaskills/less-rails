eval File.read('Gemfile.rails-3.2')

group :test do
  if RUBY_PLATFORM =~ /darwin/
    gem 'rb-fsevent'
    gem 'growl'
  end
end
