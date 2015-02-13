class AddPositionToQuestions < ActiveRecord::Migration
  def change
    add_column :formgen_questions, :position, :integer, default: 1
  end
end
