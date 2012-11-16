class Emails < ActionMailer::Base
  default :from => "satori@hcl.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.emails.forgot_password.subject
  #
  def forgot_password(to, login, pass, sent_at = Time.now)
    @subject        = "Satori: New password"
    @body['login']  = login
    @body['pass']   = pass
    @recipients     = to
    @from           = 'satori@hcl.com'
    @sent_on        = sent_at
    @headers        = {}
  end
  
  def welcome_email(user)
    @user     = user
    @url      = APP_CONFIG[:site][:address]
    @email    = user.mail
    @confirm  = User.encrypt(user.mail, user.salt)
    mail(:to => user.mail, :subject => "Welcome to Satori")
  end
end
