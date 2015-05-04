require 'test_helper'

module Formgen
  class FormTest < ActiveSupport::TestCase
    test "creation of forms" do
      start_count = Form.all.count
      Form.create!(title: 'My test form', path: 'test-form', email: 'none@formgen.org')
      assert(Form.all.count == start_count + 1)
    end

    test "export to csv" do
      form = Form.new(title: 'My test form', path: 'test-form-2', email: 'none@formgen.org')
      form.questions << Question.create!(question_type: 1, value: 'Are you sure?')
      form.questions << Question.create!(question_type: 6, value: 'What is the Answer to the Question of Life, the Universe, and Everything?')
      form.save!

      expected = "\"Are you sure?\",\"What is the Answer to the Question of Life, the Universe, and Everything?\",\"Created\"\n"
      assert(form.to_csv == expected)
    end
  end
end
