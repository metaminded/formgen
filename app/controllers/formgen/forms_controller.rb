require_dependency 'formgen/application_controller'

module Formgen
  #
  class FormsController < ApplicationController
    include QuestionsHelper

    before_action :authenticate_user! unless Formgen.skip_authentication
    before_action :find_form, only: [:edit, :update, :destroy]
    before_action :find_form_with_answers, only: [:show, :send_mail, :export]

    def index
      tabulatr_for Formgen::Form
    end

    def show
    end

    def new
      @form = Formgen::Form.new
    end

    def edit
    end

    def create
      @form = Form.new(form_params)
      if @form.save
        flash['notice'] = t('.create_success')
        redirect_to formgen.forms_path
      else
        render :new
      end
    end

    def update
      if @form.update(form_params)
        flash['notice'] = t('.update_success')
        redirect_to formgen.forms_path
      else
        render :edit
      end
    end

    def destroy
      if @form.destroy
        flash['notice'] = t('.remove_success')
      else
        flash['notice'] = t('.remove_problem')
      end
      redirect_to formgen.forms_path
    end

    def send_mail
      @form.replies.map(&:user).uniq.compact.each do |user|
        FormMailer.inform_all(user, params[:subject], params[:message]).deliver_later
      end
      redirect_to formgen.form_path(@form)
    end

    def export
      render text: @form.to_csv, content_type: 'text/csv'
    end

    private

    def find_form
      @form = Form.includes(:questions).find params[:id]
    end

    def find_form_with_answers
      @form = Form.includes(:questions, replies: [:answers, :user]).find params[:id]
    end

    def form_params
      params.require(:form).permit :title, :path, :email, :allow_anonym_answer,
                                   :email_confirm_subject, :email_confirm_body,
                                    questions_attributes: [
                                      :id, :position, :value, :language, :mandatory,
                                      :helptext, :question_type, :_destroy, options: [], options: ''
                                    ]
    end
  end
end
