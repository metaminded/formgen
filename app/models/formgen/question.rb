module Formgen
  class Question < ActiveRecord::Base
    TYPES = %w{boolean date datetime description email float integer string text time}

    belongs_to :form, inverse_of: :questions, touch: true
    has_many :answers

    validates :value, presence: true
    validates :question_type, presence: true

    def self.t_types
      TYPES.map { |type| I18n.translate("formgen.question.type.#{type}") }
    end

    def self.index_of_type type
      self.t_types.find_index type
    end

    def field_name
      "[reply][#{id}]"
    end
  end
end
