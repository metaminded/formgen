module Formgen
  module QuestionsHelper
    def get_additional_question_type(question)
      qt = Formgen::additional_question_types.select { |i, t| t[:id] == question.question_type }
      qt.present? ? qt.first.last : {}
    end

    def render_question(question, value, classes)
      get_additional_question_type(question)[:question_callback].try(:yield, question, value, classes)
    end

    def missing_field_error errors, question
      errors << t('.field_mandatory', question: question.value)
    end

    def validate_field_error errors, question
      errors << t('.field_not_valid', question: question.value)
    end

    def errors_to_html errors
      output = "<ul>"
      errors.each { |error| output << "<li>#{error}</li>" }
      output << "</ul>"
      output
    end

    def valid?(question, value)
      case Question::TYPES[question.question_type]
      when 'boolean' then     value == true || value == false
      when 'date' then        (DateTime.parse(value) rescue nil)
      when 'datetime' then    (DateTime.parse(value) rescue nil)
      when 'description' then !value
      when 'email' then       !!(value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i)
      when 'float' then       value == 0 || value.to_f != 0.0
      when 'integer' then     value == 0 || value.to_i != 0
      when 'salutation' then  I18n.t('formgen.salutations').keys.include?(value.to_sym)
      when 'string' then      true
      when 'text' then        true
      when 'time' then        (DateTime.parse(value) rescue nil)
      else get_additional_question_type(question)[:validation_callback].yield(value)
      end
    end

    def save_reply(form, remember = false)
      errors = []
      ActiveRecord::Base.transaction do
        reply_params = { form: form, user: current_user.presence.class.name == 'User' ? current_user : nil }
        if remember
          @reply = Reply.find_or_create_by! reply_params
        else
          @reply = Reply.create! reply_params
        end

        form.questions.each do |question|
          missing_field_error(errors, question) if question.mandatory && !params[:reply][question.id.to_s].present?
          validate_field_error(errors, question) if !valid?(question, params[:reply][question.id.to_s]) && params[:reply][question.id.to_s].present?
          a = Answer.find_or_initialize_by reply: @reply, question: question
          a.value = params[:reply][question.id.to_s]
          a.save!
        end
        raise ActiveRecord::Rollback unless errors.empty?
      end
      errors
    end

    def render_value(answer)
      qt = get_additional_question_type(answer.question)
      if qt[:display_callback].present?
        qt[:display_callback].yield(answer.value)
      else
        case Question::TYPES[answer.question.question_type]
          when 'salutation' then I18n.t("formgen.salutations.#{answer.value.to_s}")
          else answer.value
        end
      end
    end
  end
end
