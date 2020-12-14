# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Vote, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:votable) }

  let!(:user) { create(:user) }
  let!(:author) { create(:user) }
  let!(:votable) { create(:question, user: author) }

  describe 'Author can not vote for own resource' do
    let!(:votable) { create(:question, user: author) }

    it 'returns error' do
      vote = described_class.new(user_id: author.id, votable: votable, click: 1)
      vote.valid?
      expect(vote.errors[:user]).to include("Author can't vote")
    end
  end
end
