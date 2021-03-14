# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VotePolicy, type: :policy do
  let(:user) { create :user }
  let(:votable) { create :question, user: user }

  subject { described_class }

  permissions :vote? do
    it 'grants access if user present and user is author of votable' do
      expect(subject).to permit(User.new, votable)
    end

    it 'denies access if user is not author of voteable' do
      expect(subject).not_to permit(user, votable)
    end
  end
end
