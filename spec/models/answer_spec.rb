# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to :question }
  it { should belong_to :user }
  it { should validate_presence_of :body }
  it { should have_many(:links).dependent(:destroy) }
  it { should have_one(:award) }

  it_behaves_like 'votable model'
  it_behaves_like 'commentable model'

  it { should accept_nested_attributes_for :links }

  it 'have many attached files' do
    expect(Answer.new.files).to be_an_instance_of(ActiveStorage::Attached::Many)
  end

  describe 'set_the_best' do
    let!(:user) { create(:user) }
    let!(:question) { create(:question, user: user) }
    let!(:answer) { create(:answer, question: question, user: user) }

    it 'can select the best answer' do
      expect { answer.set_the_best }.to change(answer, :best).to(true)
    end

    context 'can be only one best answer in question' do
      let!(:other_answer) { create(:answer, question: question, user: user) }

      before do
        other_answer.set_the_best
        answer.set_the_best
      end

      it { expect(answer.reload).to be_best }
      it { expect(other_answer.reload).to_not be_best }
    end
  end

  describe 'notification' do
    let(:answer) { build(:answer) }

    it 'calls NotificationJob' do
      expect(NotificationJob).to receive(:perform_later).with(answer.question)
      answer.save!
    end
  end
end
