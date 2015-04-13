class AddOptionsToQuestion < ActiveRecord::Migration
  def change
    add_column :formgen_questions, :options, :text
  end
end
