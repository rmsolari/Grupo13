class ApplicationMailer < ActionMailer::Base
  default :from => 'TVSeries4u'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_signup_email(user)
    @user = user
    #mail( :to => @user.email,
    @recipients = []
    @recipients << 'rmsolari@uc.cl'
    @recipients << 'iocontreras@uc.cl'
    @recipients << @user.email
    mail(to: @recipients, subject: "Bienvenido!!")
  end
end
