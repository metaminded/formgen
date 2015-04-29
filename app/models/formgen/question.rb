module Formgen
  class Question < ActiveRecord::Base
    TYPES = %w{boolean date datetime description email float integer string text time salutation divider headline select radio}

    belongs_to :form, inverse_of: :questions, touch: true
    has_many :answers, dependent: :destroy

    serialize :options

    validates :value, presence: true
    validates :question_type, presence: true

    default_scope -> { order(:position) }

    scope :outputable, -> { where.not(question_type: [3, 11, 12]) }

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
