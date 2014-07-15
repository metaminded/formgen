module Formgen
  #
  class FormTabulatrData < Tabulatr::Data
    buttons do |b, r|
      b.button :eye,  formgen.form_path(r.id)
      b.button :pencil, formgen.edit_form_path(r.id)
    end

    column :title
    column :path
  end
end
