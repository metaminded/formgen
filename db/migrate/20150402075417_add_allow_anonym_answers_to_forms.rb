class AddAllowAnonymAnswersToForms < ActiveRecord::Migration
  def change
    execute <<-SQL
      ALTER TABLE formgen_forms ADD COLUMN allow_anonym_answer BOOLEAN DEFAULT false;
    SQL
  end
end
