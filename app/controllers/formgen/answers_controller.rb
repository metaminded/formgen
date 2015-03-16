require_dependency 'formgen/application_controller'

module Formgen
  #
  class AnswersController < ApplicationController
    include QuestionsHelper

    before_action :auth_user! unless Formgen.skip_answer_authentication
    before_action :find_reply, only: [:show]

    def create
      form = Form.find params[:id]
      errors = save_reply(form)
      FormMailer.send_mail(:notify, @reply) if errors.empty?

      if errors.any?
        flash[:notice] = errors_to_html(errors).html_safe
        session[:formgen_reply] = params['reply']
      else
        flash[:notice] = t('.saved_reply_successfully')
      end

      redirect_to :back
    end

    private

    def find_reply
      @reply = Reply.includes(answers: :question).find(params[:id])
    end
  end
end
