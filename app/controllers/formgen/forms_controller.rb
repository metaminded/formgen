require_dependency 'formgen/application_controller'

module Formgen
  #
  class FormsController < ApplicationController
    before_action :find_form, only: [:show, :edit, :update, :destroy]

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
        redirect_to :back
      else
        render :new
      end
    end

    def update
      if @form.update(form_params)
        flash['notice'] = t('.update_success')
        redirect_to :back
      else
        render :edit
      end
    end

    def destroy
    end

    private

    def find_form
      @form = Form.includes(:questions, replies: :answers).find params[:id]
    end

    def form_params
      params.require(:form).permit :title, :path, :email, questions_attributes:
                                    [:id, :value, :language, :mandatory,
                                     :question_type, :_destroy]
    end
  end
end
