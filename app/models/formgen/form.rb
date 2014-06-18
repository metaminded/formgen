module Formgen
  class Form < ActiveRecord::Base
    has_many :questions, inverse_of: :form
    accepts_nested_attributes_for :questions, allow_destroy: true

    has_many :replies
  end
end
