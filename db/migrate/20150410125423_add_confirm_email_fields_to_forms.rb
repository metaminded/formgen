class AddConfirmEmailFieldsToForms < ActiveRecord::Migration
  def change
    add_column :formgen_forms, :email_confirm_subject, :string
    add_column :formgen_forms, :email_confirm_body, :text
  end
end
