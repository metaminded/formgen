module Formgen
  class Form < ActiveRecord::Base
    has_many :questions, inverse_of: :form, dependent: :destroy
    accepts_nested_attributes_for :questions, allow_destroy: true

    has_many :replies, dependent: :destroy
  end
end
