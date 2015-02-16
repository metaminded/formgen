require 'test_helper'

module Formgen
  class QuestionsHelperTest < ActionView::TestCase
    test "validation of answers" do
      q = Question.new(question_type: 0, value: 'foo')  # Boolean
      assert(valid?(q, false))
      assert(valid?(q, true))
      assert_not(valid?(q, 'Yes sir'))

      q.question_type = 1                               # Date
      assert(valid?(q, DateTime.now.to_s))
      assert_not(valid?(q, 'Today is the best day ever'))

      q.question_type = 2                               # DateTime
      assert(valid?(q, DateTime.now.to_s))
      assert_not(valid?(q, 'Today is the best day ever'))

      q.question_type = 4                               # Email
      assert(valid?(q, 'none@formgen.org'))
      assert_not(valid?(q, 'Lord Vader at Deathstar dot com'))

      q.question_type = 5                               # Float
      assert(valid?(q, 15))
      assert(valid?(q, 1.5))
      assert(valid?(q, "1.5"))
      assert_not(valid?(q, 'Five'))

      q.question_type = 6                               # Integer
      assert(valid?(q, 15))
      assert(valid?(q, 1.5))
      assert(valid?(q, "1.5"))
      assert_not(valid?(q, 'Five'))

      q.question_type = 7                               # String

      q.question_type = 8                               # Text

      q.question_type = 9                               # Time

      q.question_type = 10                              # Salutation
      assert(valid?(q, 'mr'))
      assert(valid?(q, 'mrs'))
      assert(valid?(q, 'dr'))
      assert(valid?(q, 'prof'))
      assert_not(valid?(q, 'Mister'))
      assert_not(valid?(q, 'Catwoman'))
    end

    test "rendering of answers" do

    end
  end
end
