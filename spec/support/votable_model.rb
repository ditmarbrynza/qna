# frozen_string_literal: true

shared_examples 'votable model' do
  it { should have_many(:votes).dependent(:destroy) }

  describe '#rating' do
    let(:model_klass) { described_class.name.underscore.to_sym }
    let(:user) { create(:user) }
    let(:votable) { create(model_klass) }
    let!(:up) { create_list(:vote, 5, user: create(:user), votable: votable, value: 1) }
    let!(:down) { create_list(:vote, 3, user: create(:user), votable: votable, value: -1) }

    it { expect(votable.rating).to eq 2 }
  end
end
