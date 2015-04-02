class FormMailer < ActionMailer::Base
  def notify(reply)
    @reply = reply
    email = [Formgen.always_mail_to, reply.form.email].join(';')
    title = reply.form.title.presence || reply.form.path

    mail(to: email, subject: [Formgen.subject_prefix.presence, t('form_mailer.notify.new_notification_for', title: title)].join(" ").strip, template_name: 'notify')
  end

  def inform_all(user, subject, message)
    @message = message
    mail(to: user.email, subject: [Formgen.subject_prefix.presence, subject].join(" ").strip, template_name: 'inform')
  end
end
