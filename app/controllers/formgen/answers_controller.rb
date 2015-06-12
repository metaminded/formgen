require_dependency 'formgen/application_controller'

module Formgen
  #
  class AnswersController < ApplicationController
    include QuestionsHelper
    begin
      include Formgen::AnswersControllerExtension
    rescue Exception => e
    end

    before_action :authenticate_user! unless Formgen.skip_answer_authentication
    before_action :find_reply, only: [:show]

    def create
      form = Form.find params[:id]

      if form.allow_anonym_answer? || Formgen.can_answer_form.call(current_user)
        before_create(form) if respond_to?(:before_create)
        errors = save_reply(form)
        after_create(form, errors) if respond_to?(:after_create)

        if errors.empty?
          FormMailer.confirm(@reply).deliver_later if @reply.user.present?
          FormMailer.notify(@reply).deliver_later
        end
      else
        errors = [t('.not_allowed')]
      end

      if errors.any?
        flash[:error] = errors_to_html(errors).html_safe
        session[:formgen_reply] = params['reply']
      else
        flash[:success] = t('.saved_reply_successfully')
      end

      redirect_to :back
    end

    def destroy_all
      form = Form.find params[:id]
      if form.replies.destroy_all
        redirect_to form_path(form), notice: t('.success')
      else
        redirect_to form_path(form), alert: t('.failure')
      end
    end

    private

    def find_reply
      @reply = Reply.includes(answers: :question).find(params[:id])
    end
  end
end
