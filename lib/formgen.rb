require "formgen/engine"
require "formgen/railtie"

require "formgen/acts_as_form"

module Formgen
  mattr_accessor :always_mail_to
  @@always_mail_to = ''

  mattr_accessor :subject_prefix
  @@subject_prefix = ''

  mattr_accessor :additional_question_types
  @@additional_question_types = {}

  mattr_accessor :skip_authentication
  @@skip_authentication = false

  def self.setup
    yield self
  end

  def self.add_question_type(id, title, question_callback: , display_callback: nil, validation_callback: )
    additional_question_types[title.parameterize] = { id: id, title: title, question_callback: question_callback, display_callback: display_callback, validation_callback: validation_callback }
  end
end
