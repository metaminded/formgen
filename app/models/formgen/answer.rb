module Formgen
  class Answer < ActiveRecord::Base
    belongs_to :reply
    belongs_to :question, touch: true

    validates :question, presence: true

    default_scope -> { includes(:question).order('formgen_questions.position') }

    scope :outputable, -> { joins(:question).where.not(formgen_questions: { question_type: 3 }) }
  end
end
