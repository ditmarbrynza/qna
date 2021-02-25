# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many :questions }
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should have_many(:awards) }
  it { should have_many(:authorizations).dependent(:destroy) }

  describe 'author of?' do
    let(:user) { create :user }
    let(:other_user) { create :user }
    let(:question) { create :question, user: user }
    let(:answer) { create :answer, user: user, question: question }

    let(:other_question) { create :question, user: other_user }
    let(:other_answer) { create :answer, user: other_user, question: other_question }

    it { expect(user).to be_author_of(question) }
    it { expect(user).to be_author_of(answer) }

    it { expect(user).to_not be_author_of(other_question) }
    it { expect(user).to_not be_author_of(other_answer) }
  end

  describe 'find_for_oauth' do
    let!(:user) { create :user }
    let(:auth) { OmniAuth::AuthHash.new(provider: 'github', uid: '123456') }
    let(:service) { double('Services:FindForOauth') }

    it 'calls Services::FindForOauth' do
      expect(Services::FindForOauth).to receive(:new).and_return(service)
      expect(service).to receive(:call)
      User.find_for_oauth(auth)
    end
  end
end
