require_dependency 'formgen/application_controller'

module Formgen
  #
  class AnswersController < ApplicationController
    include QuestionsHelper
    begin
      include Formgen::AnswersControllerExtension
    rescue Exception => e
    end

    before_action :auth_user! unless Formgen.skip_answer_authentication
    before_action :find_reply, only: [:show]

    def create
      form = Form.find params[:id]

      if form.allow_anonym_answer? || Formgen.can_answer_form.call(current_user)
        before_create(form) if respond_to?(:before_create)
        errors = save_reply(form)
        after_create(form, errors) if respond_to?(:after_create)

        FormMailer.notify(@reply).deliver_later if errors.empty?
      else
        errors = [t('.not_allowed')]
      end

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
