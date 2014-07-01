module Formgen
  module ApplicationHelper
    include FontAwesome::Rails::IconHelper
    include AnswersHelper

    #
    #
    #
    def render_form(id: nil, path: nil, options: {})
      fail 'id_or_path_required' if id.nil? && path.nil?

      if id.present?
        form = Form.find id
      else
        form = Form.find_or_create_by path: path
      end

      render 'formgen/forms/output', form: form, options: options
    end

    #
    #
    #
    def render_form_editor(id: nil, path: nil, options: {})
      fail 'id_or_path_required' if id.nil? && path.nil?

      if id.present?
        form = Form.find id
      else
        form = Form.find_or_create_by path: path
      end

      render 'formgen/forms/form', form: form, options: options
    end

    #
    #
    #
    def render_questions_for(form_for, obj, path: nil, options: {})
      fail 'form_or_path_required' if obj.form.nil? && path.nil?
      options[:embedded] = true
      if obj.form.nil?
        obj.form = Form.find_or_create_by path: path
        obj.save
      end
      render 'formgen/forms/questions', f: form_for, form: obj.form, options: options
    end

    #
    #
    #
    def render_reply_for(form_for, obj, path: nil, options: {})
      fail 'form_or_path_required' if obj.form.nil? && path.nil?
      if obj.form.nil?
        obj.form = Form.find_or_create_by path: path
        obj.save
      end
      render 'formgen/answers/answers', f: form_for, form: obj.form, options: options
    end

    #
    #
    #
    def save_reply_for(obj)
      fail 'form_required' if obj.form.nil?
      errors = save_reply(obj.form)
      NotificationMailer.send_mail(:notify, @reply)
      errors
    end
  end
end
