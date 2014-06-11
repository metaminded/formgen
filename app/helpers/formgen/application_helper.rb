module Formgen
  module ApplicationHelper
    include FontAwesome::Rails::IconHelper

    def render_form path: '', options: {}
      path = request.path if path.empty?
      form = Form.find_or_create_by path: path

      render 'formgen/forms/output', form: form, options: options
    end
  end
end
