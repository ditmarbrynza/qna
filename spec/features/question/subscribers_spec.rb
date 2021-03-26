# frozen_string_literal: true

require 'rails_helper'

feature 'User can subscribe to questions' do
  given!(:user) { create :user }
  given!(:question) { create :question, user_id: user.id }

  describe 'Authenticated user', js: true do
    scenario 'user can subscribe to question' do
      sign_in(user)
      visit question_path(question)

      expect(page).not_to have_css('.unsubscribe-link')
      expect(page).to have_css('.subscribe-link')
      click_on 'subscribe'
      expect(page).not_to have_css('.subscribe-link')
      expect(page).to have_css('.unsubscribe-link')
    end

    scenario 'User can unsubscribe from question', js: true do
      create(:subscriber, question_id: question.id, user_id: user.id)

      sign_in(user)
      visit question_path(question)

      expect(page).not_to have_css('.subscribe-link')
      expect(page).to have_css('.unsubscribe-link')
      click_on 'unsubscribe'
      expect(page).not_to have_css('.unsubscribe-link')
      expect(page).to have_css('.subscribe-link')
    end
  end

  describe 'Unauthenticated user', js: true do
    scenario 'user can not subscribe' do
      visit question_path(question)
      expect(page).not_to have_css('.unsubscribe-link')
      expect(page).to_not have_css('.subscribe-link')
    end
  end
end
