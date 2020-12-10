# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VotesHelper, type: :helper do
  LIKE = 1
  LIKED = 1
  DISLIKE = -1
  DISLIKED = -1

  describe '#how_voted' do
    let!(:user) { create(:user) }
    let!(:author) { create(:user) }
    let!(:votable) { create(:question, user: author) }
    describe 'voted like' do
      let!(:vote) { create(:vote, user: user, votable: votable, value: 1) }
      it 'returns true' do
        expect(helper.how_voted(user, votable)).to eq LIKED
      end
    end

    describe 'voted dislike' do
      let!(:vote) { create(:vote, user: user, votable: votable, value: -1) }
      it 'returns true' do
        expect(helper.how_voted(user, votable)).to eq DISLIKED
      end
    end

    describe 'no voted' do
      it 'returns true' do
        expect(helper.how_voted(user, votable)).to eq nil
      end
    end
  end

  describe '#liked?' do
    it do
      expect(helper.liked?(LIKE)).to be_truthy
    end

    it do
      expect(helper.liked?(DISLIKE)).to be_falsey
    end
  end

  describe '#disliked?' do
    it do
      expect(helper.disliked?(DISLIKE)).to be_truthy
    end

    it do
      expect(helper.disliked?(LIKE)).to be_falsey
    end
  end
end
