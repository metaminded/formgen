class CreateFormgenReplies < ActiveRecord::Migration
  def change
    create_table :formgen_replies do |t|
      t.references :form, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
