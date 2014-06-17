module Formgen
  module ApplicationHelper
    include FontAwesome::Rails::IconHelper
    include AnswersHelper

    def render_form path: raise, options: {}
      path = request.path if path.empty?
      form = Form.find_or_create_by path: path

      render 'formgen/forms/output', form: form, options: options
    end

    def render_form_by_id form_id, options: {}
      form = Form.find form_id

      render 'formgen/forms/output', form: form, options: options
    end

    def render_form_editor path: raise, options: {}
      path = request.path if path.empty?
      @form = Form.find_or_create_by path: path

      render 'formgen/forms/form', options: options
    end

    def render_questions_for form_for, obj, path: raise, options: {}
      path = request.path if path.empty?
      form = Form.find_or_create_by path: path
      obj.form = form

      render 'formgen/forms/questions', f: form_for, options: options
    end

    def render_reply_for form_for, obj, path: raise, options: {}
      path = request.path if path.empty?
      form = Form.find_or_create_by path: path
      obj.form = form

      render 'formgen/answers/answers', f: form_for, form: form, options: options
    end

    def save_reply_for path: raise
      path = request.path if path.empty?
      @form = Form.find_by path: path

      errors = save_reply
      NotificationMailer.send_mail(:notify, @reply)
      errors
    end
  end
end
