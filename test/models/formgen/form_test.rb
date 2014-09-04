require 'test_helper'

module Formgen
  class FormTest < ActiveSupport::TestCase
    test "creation of forms" do
      start_count = Form.all.count
      Form.create!(title: 'My test form', path: 'test-form', email: 'none@formgen.org')
      assert(Form.all.count == start_count + 1)
    end
  end
end
