# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DailyDigestJob, type: :job do
  it 'calls Services::DailyDigest#send_digest' do
    expect(Services::DailyDigest).to receive(:send_digest)
    DailyDigestJob.perform_now
  end
end
