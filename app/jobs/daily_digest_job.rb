# frozen_string_literal: true

class DailyDigestJob < ApplicationJob
  queue_as :default

  def perform
    Services::DailyDigest.send_digest
  end
end
