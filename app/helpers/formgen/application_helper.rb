module Formgen
  module ApplicationHelper
    include FontAwesome::Rails::IconHelper

    def render_form path: '', options: {}
      path = request.path if path.empty?
      form = Form.find_or_create_by path: path

      render 'formgen/forms/output', form: form, options: options
    end

    def render_form_replies path: '', options: {}
      path = request.path if path.empty?
      form = Form.find_or_create_by path: path

      render 'formgen/answers/output', form: form, options: options
    end

    def render_form_editor path: '', options: {}
      path = request.path if path.empty?
      @form = Form.find_or_create_by path: path

      render 'formgen/forms/form', options: options
    end

    def render_questions_for form_for, obj, path: '', options: {}
      path = request.path if path.empty?
      form = Form.find_or_create_by path: path
      obj.form = form

      render 'formgen/forms/questions', f: form_for, options: options
    end

    def render_reply_into_other_form path: '', options: {}

    end

    def save_reply_out_of_other_form path: '', params: {}

    end
  end
end
