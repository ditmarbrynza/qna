# frozen_string_literal: true

class DailyDigestMailer < ApplicationMailer
  def digest(user)
    @questions = Question.where(created_at: (Time.now.midnight - 1.day)..Time.now.midnight)
    return if @questions.empty?

    mail to: user.email
  end
end
