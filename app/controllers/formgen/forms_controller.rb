require_dependency 'formgen/application_controller'

module Formgen
  #
  class FormsController < ApplicationController
    before_action :get_form, only: [:show, :edit, :update, :destroy]

    def index
      tabulatr_for Formgen::Form
    end

    def show
    end

    def new
      @form = Form.new
    end

    def edit
    end

    def create
      @form = Form.new(form_params)
      if @form.save
        redirect_to :back
      else
        render :new
      end
    end

    def update
      if @form.update(form_params)
        redirect_to :back
      else
        render :edit
      end
    end

    def destroy
    end

    private

    def get_form
      @form = Form.includes(:questions, replies: :answers).find params[:id]
    end

    def form_params
      params.require(:form).permit :title, :path, :email, questions_attributes: [:id, :value, :language, :mandatory, :question_type, :_destroy]
    end
  end
end
