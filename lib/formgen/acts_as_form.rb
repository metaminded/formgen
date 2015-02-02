module Formgen
  module ActsAsForm
    extend ActiveSupport::Concern

    def self.included(base)
      base.class_eval do
        belongs_to :form, class_name: 'Formgen::Form'
        has_many :questions, primary_key: 'form_id', foreign_key: 'form_id', class_name: 'Formgen::Question', inverse_of: :form
        accepts_nested_attributes_for :questions, allow_destroy: true

        define_method :questions do
          self.form.try(:questions)
        end

        define_singleton_method :question_params do
          [:form_id, { questions_attributes: [:id, :value, :language, :mandatory, :question_type, :_destroy] }].flatten
        end
      end
    end
  end
end
