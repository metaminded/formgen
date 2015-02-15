module Formgen
  class Answer < ActiveRecord::Base
    belongs_to :reply
    belongs_to :question, touch: true

    validate :question_id, presence: true
  end
end
