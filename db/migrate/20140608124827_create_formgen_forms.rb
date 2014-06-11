class CreateFormgenForms < ActiveRecord::Migration
  def change
    create_table :formgen_forms do |t|
      t.string :title
      t.string :path
      t.string :email

      t.timestamps
    end

    create_table :formgen_questions do |t|
      t.references :form
      t.string :value
      t.string :language
      t.boolean :mandatory
      t.integer :question_type

      t.timestamps
    end
  end
end
