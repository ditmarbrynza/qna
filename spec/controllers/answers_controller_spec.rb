require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }
  let(:answer) { create(:answer) }

  describe "POST #create" do
    context 'with valid attributes' do
      it 'saves a new answer in the database' do
        expect { post :create, params: { question_id: question.id, answer: {question_id: question.id, body: "body"} } }.to change(Answer, :count).by(1)
      end
    end
  end
end