require_dependency "formgen/application_controller"

module Formgen
  class AnswersController < ApplicationController
    include AnswersHelper

    def show
    end

    def create
      errors = []
      @form = Form.find params[:id]
      ActiveRecord::Base.transaction do
        @reply = Reply.create! form: @form, user: current_user.present? ? current_user : nil
        @form.questions.each do |question|
          missing_field_error(errors, question) if question.mandatory && params[:reply][question.id.to_s].empty?
          Answer.create! reply: @reply, question: question, value: params[:reply][question.id.to_s]
        end
        raise ActiveRecord::Rollback unless errors.empty?
      end

      if errors.any?
        flash[:notice] = errors_to_html errors
      else
        flash[:notice] = t('.saved_reply_successfully')
      end
      
      redirect_to :back
    end
  end
end
