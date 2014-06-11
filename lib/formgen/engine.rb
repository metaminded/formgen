module Formgen
  class Engine < ::Rails::Engine
    isolate_namespace Formgen


    initializer 'formgen.action_controller' do |app|
      ActiveSupport.on_load :action_controller do
        helper Formgen::ApplicationHelper
      end
    end
  end
end
