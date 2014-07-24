class FormMailer < ActionMailer::Base
  def notify(reply)
    @reply = reply
    email = "#{Formgen.always_mail_to};#{reply.form.email}"
    title = reply.form.title.presence || reply.form.path

    mail(to: email, subject: [Formgen.subject_prefix.presence, t('form_mailer.notify.new_notification_for', title: title)].join(" ").strip, template_name: 'notify')
  end

  def inform_all(form, subject, message)
    @message = message
    emails = form.replies.map { |reply| reply.user.email if reply.user.present? }.compact.uniq.join(';')
    mail(to: emails, subject: [Formgen.subject_prefix.presence, subject].join(" ").strip, template_name: 'inform')
  end

  def send_mail(method, *args)
    send(method, *args).deliver
  end
end
