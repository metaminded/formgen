module Formgen
  module AnswersHelper
    def missing_field_error errors, question
      errors << t('.field_mandatory', question.value)
    end

    def errors_to_html errors
      output = "<ul>"
      errors.each { |error| output << "<li>#{error}</li>" }
      output << "</ul>"
      output
    end
  end
end
