class NotificationMailer < ActionMailer::Base
  def notify(reply)
    @reply = reply
    email = reply.form.email
    title = reply.form.title.presence || reply.form.path

    mail(from: 'me', to: email, subject: t('notification_mailer.notify.new_notification_for', title: title), template_name: 'notify')
  end

  def send_mail(method, *args)
    send(method, *args).deliver
  end
end
