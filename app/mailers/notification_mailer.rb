class NotificationMailer < ActionMailer::Base
  def notify(reply)
    @reply = reply
    email = reply.form.email
    title = reply.form.title

    mail(from: '', to: email, subject: t('.new_notification_for', title: title), template_name: 'notify')
  end

  def send_mail(method, *args)
    send(method, *args).deliver
  end
end
