module Formgen
  #
  class FormTabulatrData < Tabulatr::Data
    buttons do |b, r|
      b.button :eye,  formgen.form_path(r.id)
      b.button :pencil, formgen.edit_form_path(r.id)
      b.submenu do |s|
        s.button :times, formgen.form_path(record.id), label: I18n.t('.delete'), method: :delete, data: { confirm: I18n.t('.are_you_sure')}
      end
    end

    column :title
    column :path
  end
end
