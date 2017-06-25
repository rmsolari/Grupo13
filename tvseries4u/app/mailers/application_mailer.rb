class ApplicationMailer < ActionMailer::Base
  default :from => 'TVSeries4u@TVSeries4u.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_signup_email(user)
    @user = user
    #mail( :to => @user.email,
    @recipients = []
    @recipients << 'rmsolari@uc.cl'
    @recipients << 'rmsolari@gmail.com'

    @recipients << @user.email
    mail(to: @recipients, subject: "Bienvenido!!")
  end

  def send_list(user)
    @user = user
    @recipients = []
    @recipients << @user.email
    @recipients << 'rmsolari@gmail.com'
    mail(to: @recipients, subject: "Lista de series TVSeries4u")
  end
end
