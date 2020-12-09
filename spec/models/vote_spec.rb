# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Vote, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:votable) }

  let!(:user) { create(:user) }
  let!(:author) { create(:user) }
  let!(:votable) { create(:question, user: author) }

  describe '#up' do
    context 'like' do
      it { expect(described_class.up(user, votable)).to be_an_instance_of(Vote) }
    end

    context 'reset like' do
      let!(:up) { create(:vote, user: user, votable: votable, value: 1) }

      it 'returns nil' do
        expect(described_class.up(user, votable)).to eq nil
      end

      it 'destroy vote' do
        expect { described_class.up(user, votable) }.to change(Vote, :count).by(-1)
      end
    end

    context 'Author can not vote for own resource' do
      let!(:votable) { create(:question, user: author) }

      it 'returns error' do
        vote = described_class.up(author, votable)
        vote.valid?
        expect(vote.errors[:user]).to include("Author can't vote")
      end
    end
  end

  describe '#down' do
    context 'like' do
      it { expect(described_class.down(user, votable)).to be_an_instance_of(Vote) }
    end

    context 'reset like' do
      let!(:down) { create(:vote, user: user, votable: votable, value: -1) }

      it 'returns nil' do
        expect(described_class.down(user, votable)).to eq nil
      end

      it 'destroy vote' do
        expect { described_class.down(user, votable) }.to change(Vote, :count).by(-1)
      end
    end

    context 'Author can not vote for own resource' do
      let!(:votable) { create(:question, user: author) }

      it 'returns error' do
        vote = described_class.down(author, votable)
        vote.valid?
        expect(vote.errors[:user]).to include("Author can't vote")
      end
    end
  end
end
