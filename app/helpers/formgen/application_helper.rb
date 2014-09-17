module Formgen
  module ApplicationHelper
    #include FontAwesome::Rails::IconHelper
    include QuestionsHelper

    #
    #
    #
    def render_form(id: nil, path: nil, title: nil, options: {})
      fail 'id_or_path_required' if id.nil? && path.nil?

      if id.present?
        form = Form.find id
      else
        form = Form.find_or_create_by path: path do |f|
          f.title = title if title.present?
        end
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
    def count_questions_for(id: nil, path: nil)
      if id.present?
        form = Form.find id
      else
        form = Form.find_by path: path
      end
      form.present? ? form.questions.count : 0
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
    def save_reply_for(obj, options: {})
      fail 'form_required' if obj.form.nil?
      errors = save_reply(obj.form, options[:remember].presence)
      NotificationMailer.send_mail(:notify, @reply) if errors.empty?
      errors
    end
  end
end
