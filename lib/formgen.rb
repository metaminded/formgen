require "formgen/engine"
require "formgen/railtie"

require "formgen/acts_as_form"

module Formgen
  mattr_accessor :always_mail_to
  @@always_mail_to = ''

  mattr_accessor :subject_prefix
  @@subject_prefix = ''

  def self.setup
    yield self
  end
end
