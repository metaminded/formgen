require 'test_helper'

module Formgen
  class QuestionTest < ActiveSupport::TestCase
    test 'translated question types' do
      types = Question.t_types
      expected = ['Yes/No', 'Date', 'Date with time', 'Description (no answers allowed)',
                  'Email', 'Floatingnumber', 'Number', 'Text', 'Longtext', 'Time', 'Salutation',
                  'Divider', 'Headline', 'Select-Box', 'Radio-Buttons']
      assert(types == expected)
    end

    test 'index of question type' do
      assert(Question.index_of_type('Yes/No') == 0)
      assert(Question.index_of_type('Date') == 1)
      assert(Question.index_of_type('Date with time') == 2)
      assert(Question.index_of_type('Description (no answers allowed)') == 3)
      assert(Question.index_of_type('Email') == 4)
      assert(Question.index_of_type('Floatingnumber') == 5)
      assert(Question.index_of_type('Number') == 6)
      assert(Question.index_of_type('Text') == 7)
      assert(Question.index_of_type('Longtext') == 8)
      assert(Question.index_of_type('Time') == 9)
      assert(Question.index_of_type('Salutation') == 10)
      assert(Question.index_of_type('Divider') == 11)
      assert(Question.index_of_type('Headline') == 12)
      assert(Question.index_of_type('Select-Box') == 13)
      assert(Question.index_of_type('Radio-Buttons') == 14)
    end
  end
end
