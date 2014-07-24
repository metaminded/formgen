module Formgen
  module AnswersHelper
    def missing_field_error errors, question
      errors << t('.field_mandatory', question: question.value)
    end

    def errors_to_html errors
      output = "<ul>"
      errors.each { |error| output << "<li>#{error}</li>" }
      output << "</ul>"
      output
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
          Answer.create! reply: @reply, question: question, value: params[:reply][question.id.to_s]
        end
        raise ActiveRecord::Rollback unless errors.empty?
      end
      errors
    end
  end
end
