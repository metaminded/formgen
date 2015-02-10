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
      when 'boolean' then true
      when 'date' then true
      when 'datetime' then true
      when 'description' then true
      when 'email' then !!(value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i)
      when 'float' then true
      when 'integer' then true
      when 'string' then true
      when 'text' then true
      when 'time' then true
      else get_additional_question_type(question)[:validation_callback].yield(value)
      end
    end

    def save_reply(form, remember = false)
      errors = []
      ActiveRecord::Base.transaction do
        reply_params = { form: form, user: current_user.presence.class.name == 'User' ? current_user : nil }
        if remember
          @reply = Reply.find_or_create_by reply_params
        else
          @reply = Reply.create! reply_params
        end

        form.questions.each do |question|
          missing_field_error(errors, question) if question.mandatory && !params[:reply][question.id.to_s].present?
          validate_field_error(errors, question) if !valid?(question, params[:reply][question.id.to_s]) && params[:reply][question.id.to_s].present?
          Answer.create! reply: @reply, question: question, value: params[:reply][question.id.to_s]
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
        answer.value
      end
    end
  end
end
