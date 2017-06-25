# Load the Rails application.
require_relative 'application'
# Initialize the Rails application.
Rails.application.initialize!
ActionMailer::Base.smtp_settings = {
  :user_name => 'postmaster@sandboxc28e7d76209a41a88f32771315672509.mailgun.org',
  :password => '26a98f0f529722f43ad5aa7bbd7c7152',
  :domain => 'sandboxc28e7d76209a41a88f32771315672509.mailgun.org',
  :address => 'smtp.mailgun.org',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}
