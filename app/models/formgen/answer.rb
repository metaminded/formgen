module Formgen
  class Answer < ActiveRecord::Base
    belongs_to :reply
    belongs_to :question, touch: true

    validates :question, presence: true
  end
end
