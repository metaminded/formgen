module Formgen
  class ApplicationController < ::ApplicationController
    layout "#{Formgen.route_namespace}application"
    I18n.load_path += Dir.glob( File.dirname(__FILE__)  + '/../../../config/locales/*.{rb,yml}')
  end
end
