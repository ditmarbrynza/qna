# frozen_string_literal: true

require 'rails_helper'

feature 'User can add links to answer' do
  given!(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:gist_url) { 'https://gist.github.com/ditmarbrynza/687396798cf35611e83449066fc0a78e' }
  given!(:google_url) { 'https://google.com' }

  describe 'Authenticated user asks question', js: true do
    background do
      sign_in(user)
      visit question_path(question)
      fill_in 'Body', with: 'written answer'
      click_on 'add link'
      fill_in 'Link name', with: 'Google'
      fill_in 'Link url', with: google_url
    end

    scenario 'User can adds one link' do
      click_on 'Answer'
      within '.answers' do
        expect(page).to have_link 'Google', href: google_url
      end
    end

    scenario 'User can adds two links' do
      click_on 'add link'

      within all('.nested-fields').last do
        fill_in 'Link name', with: 'My gist'
        fill_in 'Link url', with: 'https://github.com'
      end

      click_on 'Answer'

      expect(page).to have_link 'My gist', href: 'https://github.com'
      expect(page).to have_link 'Google', href: google_url
    end

    scenario 'adds gist link when answer' do
      fill_in 'Link url', with: gist_url
      click_on 'Answer'
      expect(page).to have_content 'test-guru-question.txt'
      expect(page).to have_content 'What is JS Events? An event is a signal from the browser that something has happened.'
    end

    scenario 'adds invalid link when ask question' do
      fill_in 'Link url', with: 'wront_url/add'

      click_on 'Answer'

      expect(page).to have_content 'Links url is invalid'
      expect(page).to_not have_link 'My link', href: 'wront_url/add'
    end
  end
end
