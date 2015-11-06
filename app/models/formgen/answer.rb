module Formgen
  class Answer < ActiveRecord::Base
    belongs_to :reply
    belongs_to :question, touch: true

    validates :question, presence: true

    default_scope -> { joins(:question).order('formgen_questions.position asc, formgen_questions.id asc') }

    scope :outputable, -> { joins(:question).where.not(formgen_questions: { question_type: [3, 11, 12] }) }
  end
end
