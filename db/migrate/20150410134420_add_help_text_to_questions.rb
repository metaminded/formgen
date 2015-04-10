class AddHelpTextToQuestions < ActiveRecord::Migration
  def change
    add_column :formgen_questions, :helptext, :string
  end
end
