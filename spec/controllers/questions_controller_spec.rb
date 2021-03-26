# frozen_string_literal: true

require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  it_behaves_like 'voted controller'
  let(:user) { create :user }
  let(:question) { create :question, user: user }
  let(:answer) { create :answer, question: question, user: user }

  describe 'GET #index' do
    let(:questions) { create_list(:question, 3, user: user) }
    before { get :index }

    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    let(:answers) { create_list :answer, 3, question: question, user: user }

    before { get :show, params: { id: question } }

    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq(question)
    end

    it 'populates an array of @answers' do
      expect(assigns(:answers)).to match_array(answers)
    end

    it 'assigns new link for answer' do
      expect(assigns(:answer).links.first).to be_a_new(Link)
    end

    it 'render show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    context 'Authenticated user' do
      before { login(user) }
      before { get :new }

      it 'assigns a new Question to @question' do
        expect(assigns(:question)).to be_a_new(Question)
      end

      it 'assigns a new link to question' do
        expect(assigns(:question).links.first).to be_a_new(Link)
      end

      it 'render new view' do
        expect(response).to render_template :new
      end
    end

    context 'Unauthenticated user' do
      before { get :new }

      it 'redirects to login page' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'POST #create' do
    context 'Authenticated user' do
      before { login(user) }

      context 'with valid attributes' do
        it 'saves a new question in the database' do
          expect do
            post :create, params: { question: attributes_for(:question), user_id: user }
          end.to change(Question, :count).by(1)
        end

        it 'redirects to show view' do
          post :create, params: { question: attributes_for(:question), user_id: user }
          expect(response).to redirect_to question_path(assigns(:question))
        end

        it 'redirects to show view' do
          post :create, params: { question: attributes_for(:question), user_id: user }
          expect(response).to redirect_to question_path(assigns(:question))
        end
      end

      context 'create subscribtion for questions owner' do
        it 'has a valid question' do
          post :create, params: { question: attributes_for(:question), user_id: user }
          expect(assigns(:subscriber).question).to eq assigns(:question)
        end

        it 'has a valid user' do
          post :create, params: { question: attributes_for(:question), user_id: user }
          expect(assigns(:subscriber).user).to eq user
        end
      end

      context 'with invalid attributes' do
        it 'does not save the question' do
          expect do
            post :create, params: { question: attributes_for(:question, :invalid), user_id: user }, format: :js
          end.to_not change(Question, :count)
        end

        it 'render templete create' do
          post :create, params: { question: attributes_for(:question, :invalid), user_id: user }, format: :js
          expect(response).to render_template :create
        end
      end
    end

    context 'Unauthenticated user' do
      it 'does not save the question' do
        expect do
          post :create, params: { question: attributes_for(:question), user_id: user }
        end.to_not change(Question, :count)
      end

      it 'redirect to sign in page' do
        post :create, params: { question: attributes_for(:question), user_id: user }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'PATCH #update' do
    context 'Authenticated user' do
      before { login(user) }

      context 'with valid attributes' do
        it 'assigns the requested question to @question' do
          patch :update, params: { id: question, question: attributes_for(:question), user_id: user }, format: :js
          expect(assigns(:question)).to eq question
        end

        it 'changes question attributes' do
          patch :update, params: { id: question, question: { title: 'new title', body: 'new body' }, user_id: user }, format: :js
          question.reload

          expect(question.title).to eq 'new title'
          expect(question.body).to eq 'new body'
        end

        it 'redirects to updated question' do
          patch :update, params: { id: question, question: attributes_for(:question), user_id: user }, format: :js
          expect(response).to redirect_to question
        end
      end

      context 'with invalid attributes' do
        before { patch :update, params: { id: question, question: attributes_for(:question, :invalid), user_id: user }, format: :js }

        it 'does not change question' do
          question.reload
          expect(question.title).to eq question.title
          expect(question.body).to eq question.body
        end

        it 'render update view' do
          expect(response).to render_template :update
        end
      end
    end

    context 'Unauthenticated user' do
      it 'not changes question attributes' do
        patch :update, params: { id: question, question: { title: 'new title', body: 'new body' }, user_id: user }, format: :js
        question.reload

        expect(question.title).to eq question.title
        expect(question.body).to eq question.body
      end

      it 'redirects to sign in page' do
        patch :update, params: { id: question, question: attributes_for(:question), user_id: user }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'Authenticated user' do
      before { login(user) }

      let!(:question) { create(:question, user: user) }

      it 'deletes the question' do
        expect { delete :destroy, params: { id: question, user_id: user } }.to change(Question, :count).by(-1)
      end

      it 'redirects to index' do
        delete :destroy, params: { id: question, user_id: user }
        expect(response).to redirect_to root_path
      end
    end

    context 'Unauthenticated user' do
      let!(:question) { create(:question, user: user) }

      it 'could not delete the question' do
        expect { delete :destroy, params: { id: question, user_id: user } }.to_not change(Question, :count)
      end

      it 'redirects to sign in page' do
        delete :destroy, params: { id: question, user_id: user }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
