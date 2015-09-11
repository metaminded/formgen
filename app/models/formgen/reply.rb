module Formgen
  ##
  # A reply is a response to a form.
  # It contains the answers to the questions of the form.
  #
  class Reply < ActiveRecord::Base
    belongs_to :form
    belongs_to :user
    has_many :answers, dependent: :destroy

    validates :form, presence: true
  end
end
