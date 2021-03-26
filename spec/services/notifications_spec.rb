# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::Notification do
  let(:users) { create_list(:user, 3) }
  let(:question) { create_list(:question, 3) }

  it 'sends notification to all subscribers' do
    Subscriber.find_each do |subscriber|
      expect(NotificationMailer).to receive(:notify_question_subscriber).with(subscriber.user, question).and_call_original
    end

    Services::Notification.notify_question_subscribers(question)
  end

  it 'does not send notification to users without subscription' do
    users.each do |user|
      expect(NotificationMailer).to_not receive(:notify_question_subscriber).with(user, question)
    end

    Services::Notification.notify_question_subscribers(question)
  end
end
