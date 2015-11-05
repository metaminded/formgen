module Formgen
  ##
  # Define the data displayed in the form overview table.
  #
  class FormTabulatrData < Tabulatr::Data
    buttons do |b, r|
      b.button :eye,  formgen.form_path(r.id)
      b.button :pencil, formgen.edit_form_path(r.id)
      b.submenu do |s|
        s.button :times, formgen.form_path(record.id),
                         label: I18n.t('formgen.action.delete'),
                         method: :delete,
                         data: { confirm: I18n.t('formgen.action.are_you_sure')}
      end
    end

    column :title
    column :path
    column :questions, sortable: false, filter: false do |record|
      record.questions.count.to_s
    end
    column :answers, sortable: false, filter: false do |record|
      record.replies.count.to_s
    end
  end
end
