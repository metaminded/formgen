module Formgen
  class Answer < ActiveRecord::Base
    belongs_to :reply
    belongs_to :question, touch: true

    validates :question, presence: true

    default_scope -> { includes(:question).order('formgen_questions.position') }
  end
end
