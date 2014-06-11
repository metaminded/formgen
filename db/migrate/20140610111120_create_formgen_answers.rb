class CreateFormgenAnswers < ActiveRecord::Migration
  def change
    create_table :formgen_answers do |t|
      t.references :reply, index: true
      t.references :question, index: true
      t.text :value

      t.timestamps
    end
  end
end
