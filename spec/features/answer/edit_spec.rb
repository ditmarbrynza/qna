require 'rails_helper'

feature 'user can edit his answer' do
  given!(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, user: user, question: question) }
  given!(:other_user) { create(:user) }

  describe 'Authenticated user', js: true do
    scenario 'can edit his answer' do
      sign_in user
      visit question_path(question)
      click_on "Edit"

      within '.answers' do
        fill_in 'Your answer', with: 'edited answer'
        click_on 'Save'

        expect(page).to_not have_content answer.body
        expect(page).to have_content 'edited answer'
      end
    end

    scenario 'can not edit other answer' do
      sign_in other_user
      visit question_path(question)
      expect(page).to_not have_link "Edit"
    end

    scenario 'edit his answer with errors' do
      sign_in user
      visit question_path(question)
      click_on "Edit"

      within '.answers' do
        fill_in 'Your answer', with: ''
        click_on 'Save'
        expect(page).to have_content "Body can't be blank"
      end
    end
  end

  scenario 'Unauthenticated can not edit answer' do
    visit question_path(question)

    expect(page).to_not have_link "Edit"
  end
end