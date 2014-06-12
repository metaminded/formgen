module Formgen
  module ActsAsForm
    extend ActiveSupport::Concern

    def self.included(base)
      base.class_eval do
        belongs_to :form, class_name: 'Formgen::Form'
        has_many :questions, foreign_key: 'form_id', class_name: 'Formgen::Question'
        accepts_nested_attributes_for :questions

        define_method :questions do
          self.form.questions
        end

        define_singleton_method :question_params do
          { questions_attributes: [:id, :value, :language, :mandatory, :question_type, :_destroy] }
        end
      end
    end
  end
end
