# frozen_string_literal: true

ActionMailer::Base.smtp_settings = {
  address: 'smtp.gmail.com',
  port: 587,
  user_name: Rails.application.credentials[Rails.env.to_sym][:mailer][:user_name],
  password: Rails.application.credentials[Rails.env.to_sym][:mailer][:password],
  domain: 'http://65.21.61.45',
  authentication: 'plain',
  enable_starttls_auto: true
}
