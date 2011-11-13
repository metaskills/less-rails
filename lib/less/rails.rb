module Less
  module Rails
    autoload :LessTemplate, 'less/rails/template_handlers'
  end
end

require 'less'
require 'rails'
require 'tilt'
require 'sprockets'
require 'sprockets/railtie'

require 'less/rails/version'
require 'less/rails/helpers'
require 'less/rails/railtie'
