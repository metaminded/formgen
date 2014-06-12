module Formgen
  class Railtie < Rails::Railtie
    initializer "formgen.application_helper" do
      ActionView::Base.send :include, ApplicationHelper
    end
  end
end
