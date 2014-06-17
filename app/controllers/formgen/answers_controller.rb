require_dependency "formgen/application_controller"

module Formgen
  class AnswersController < ApplicationController
    include AnswersHelper

    before_action :get_reply, only: [:show]

    def create
      errors = []
      @form = Form.find params[:id]
      errors = save_reply
      NotificationMailer.send_mail(:notify, @reply)

      if errors.any?
        flash[:notice] = errors_to_html errors
      else
        flash[:notice] = t('.saved_reply_successfully')
      end

      redirect_to :back
    end

    private

    def get_reply
      @reply = Reply.includes(answers: :question).find(params[:id])
    end
  end
end
