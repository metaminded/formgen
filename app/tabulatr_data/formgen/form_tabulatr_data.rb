module Formgen
  #
  class FormTabulatrData < Tabulatr::Data
    column :actions, table_column_options: { header: '', sortable: false, filter: false } do
      [
        link_to(fa_icon('edit'), formgen.edit_form_path(record.id)),
        link_to(fa_icon('eye'), formgen.form_path(record.id))
      ]
    end
    column :title
    column :path
  end
end
