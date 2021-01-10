shared_examples_for 'creating comments' do
  describe 'Authenticated user', js: true do
    background do
      sign_in(user)
      visit path
    end

    scenario 'can create a comment' do
      expect(page).to_not have_content 'New comment text'

      within html_class do
        fill_in 'Comment', with: 'New comment text'
        click_on 'Send'

        expect(page).to have_content 'New comment text'
      end
    end

    scenario 'could not create invalid comment' do
      within html_class do
        click_on 'Send'
      end

      expect(page).to have_content "can't be blank"
    end
  end

  describe 'multiple sessions' do
    scenario "comment appears on another user's page near the same resource", js: true do
      Capybara.using_session('user') do
        sign_in(user)
        visit path
      end

      Capybara.using_session('guest') do
        visit path
      end

      Capybara.using_session('user') do
        within html_class do
          fill_in 'Comment', with: 'New comment text'
          click_on 'Send'

          expect(page).to have_content 'New comment text'
        end
      end

      Capybara.using_session('guest') do
        within html_class do
          expect(page).to have_content 'New comment text'
        end
      end
    end

    scenario "comment does not appear on another user's page near the different resource", js: true do
      Capybara.using_session('user') do
        sign_in(user)
        visit path
      end

      Capybara.using_session('guest') do
        visit guest_path
      end

      Capybara.using_session('user') do
        within html_class do
          fill_in 'Comment', with: 'New comment text'
          click_on 'Send'

          expect(page).to have_content 'New comment text'
        end
      end

      Capybara.using_session('guest') do
        within guest_html_class do
          expect(page).to_not have_content 'New comment text'
        end
      end
    end
  end

  describe 'Unauthenticated user' do
    scenario 'could not create a comment' do
      visit path
      expect(page).to_not have_content 'Comment'
    end
  end
end
