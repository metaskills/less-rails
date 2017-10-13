module Less
  module Rails
  end
end

require 'less'
require 'rails'
require 'sprockets'
begin
 require 'sprockets/railtie'
rescue LoadError
 require 'sprockets/rails/railtie'
end

require 'less/rails/version'
require 'less/rails/helpers'
require 'less/rails/less_transformer'
require 'less/rails/import_processor'
require 'less/rails/railtie'
