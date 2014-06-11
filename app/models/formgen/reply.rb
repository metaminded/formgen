module Formgen
  class Reply < ActiveRecord::Base
    belongs_to :form
    belongs_to :user
    has_many :answers
  end
end
