eval File.read('Gemfile.rails-3.2')

gem "therubyracer", ">= 0.10.1", :require => nil, :platforms => :ruby
gem "therubyrhino", ">= 1.73.2", :require => nil, :platforms => :jruby

group :test do
  if RUBY_PLATFORM =~ /darwin/
    gem 'rb-fsevent'
    gem 'growl'
  end
end
