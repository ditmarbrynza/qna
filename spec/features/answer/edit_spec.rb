require 'rails_helper'

feature 'user can edit his answer' do
  given!(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, user: user, question: question) }
  given!(:other_user) { create(:user) }

  describe 'Authenticated user', js: true do
    background do
      sign_in user
      visit question_path(question)
    end

    scenario 'can edit his answer' do
      within '.answers' do
        click_on "Edit"
        fill_in 'Your answer', with: 'edited answer'
        click_on 'Save'

        expect(page).to_not have_content answer.body
        expect(page).to have_content 'edited answer'
        expect(page).to_not have_selector 'textarea'
      end
    end

    scenario 'edit his answer with errors' do
      within '.answers' do
        click_on "Edit"
        fill_in 'Your answer', with: ''
        click_on 'Save'
        expect(page).to have_content "Body can't be blank"
      end
    end

    context 'attachments' do
      scenario 'add attachments' do
        within '.answers' do
          click_on "Edit"
          attach_file 'File', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
          click_on 'Save'
  
          expect(page).to have_link 'rails_helper.rb'
          expect(page).to have_link 'spec_helper.rb'
        end
      end

      scenario 'delete attachments' do
      end

      scenario 'do not add attachments to not own question' do
      end
    end
  end

  scenario 'Other user can not edit answer' do
    sign_in other_user
    visit question_path(question)
    within '.answers' do
      expect(page).to_not have_link "Edit"
    end
  end

  scenario 'Unauthenticated can not edit answer' do
    visit question_path(question)

    expect(page).to_not have_link "Edit"
  end
end
