require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create :user }
  let(:question) { create :question, user: user }
  let(:answer) { create :answer, user: user }
  
  describe "POST #create" do
    context 'with valid attributes' do
      before { login(user) }
      it 'saves a new answer in the database' do
        expect { post :create, params: { question_id: question.id, answer: {body: "body"} } }.to change(question.answers, :count).by(1)
      end

      it 'redirects to question page' do
        post :create, params: { question_id: question.id, answer: {body: "body"} }
        expect(response).to redirect_to assigns(:question)
      end
    end

    context "with invalid attributes" do
      before { login(user) }
      it 'does not save the question' do
        expect { post :create, params: { question_id: question.id, answer: attributes_for(:answer, :invalid) } }.to_not change(question.answers, :count)
      end

      it 're-renders new view' do
        post :create, params: { question_id: question.id, answer: attributes_for(:answer, :invalid) }
        expect(response).to redirect_to assigns(:question)
      end
    end
  end
end