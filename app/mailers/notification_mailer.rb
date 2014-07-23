class NotificationMailer < ActionMailer::Base
  def notify(reply)
    @reply = reply
    email = "#{Formgen.always_mail_to};#{reply.form.email}"
    title = reply.form.title.presence || reply.form.path

    mail(to: email, subject: [Formgen.subject_prefix.presence, t('notification_mailer.notify.new_notification_for', title: title)].join(" ").strip, template_name: 'notify')
  end

  def send_mail(method, *args)
    send(method, *args).deliver
  end
end
