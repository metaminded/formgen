module Formgen
  module AnswersHelper
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
      puts "="*30
      puts question.question_type
      puts "="*30
      case question.question_type
      when 0 then true
      when 1 then true
      when 2 then true
      when 3 then !!(value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i)
      when 4 then true
      when 5 then true
      when 6 then true
      when 7 then true
      when 8 then true
      else false
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
          missing_field_error(errors, question) if question.mandatory && params[:reply][question.id.to_s].empty?
          validate_field_error(errors, question) if !valid?(question, params[:reply][question.id.to_s]) && params[:reply][question.id.to_s].present?
          Answer.create! reply: @reply, question: question, value: params[:reply][question.id.to_s]
        end
        raise ActiveRecord::Rollback unless errors.empty?
      end
      errors
    end
  end
end
