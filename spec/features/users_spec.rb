require 'rails_helper'


feature 'User creates an account' do
  Capybara.javascript_driver = :poltergeist

  feature 'without signing up can' do

    background do
      visit '/categories'
    end

    scenario 'visit categories index' do
      expect(page).to have_text "Categories"
      expect(page).to have_button "Show"
    end

  end

  background do
    visit '/'
    click_link 'Sign Up'
  end

  scenario "STEP 0: takes me to the sign up page" do
    expect(page).to have_button 'Create Account'
  end

  feature 'STEP 1: creates an account' do

    feature 'fails to create an account' do
      background do
        visit '/users/new'
        click_button "Create Account"
      end

      scenario 'fails to create an account' do
        expect(page).to have_text "Username can't be blank"
        expect(page).to have_text "Email can't be blank"
        expect(page).to have_text "Email only valid email addresses"
        expect(page).to have_text "Password can't be blank"
      end
    end

    background do
      visit '/users/new'
      within(".form") do
        fill_in "Username", with: "jim"
        fill_in "Email", with: "jim@jim.com"
        fill_in "Password", with: "jimjim"
      end
      click_button "Create Account"
    end

    scenario 'signs me up' do
      expect(page).to have_text "User was created successfully."
    end

    feature 'STEP 2: user logs out successfully' do

      background do
        click_link "Logout"
      end

      scenario 'signs me out' do
        expect(page).to have_text "You logged out successfully"
        expect(page).not_to have_text "Order History"
      end

      feature 'STEP 3: user can go to login page' do

        background do
          click_link "Login"
        end

        scenario "takes me to login page" do
          expect(page).to have_button "Log in"
        end

        feature 'STEP 4: user can login' do

          feature 'fails to login' do
            background do
              visit '/login'
              click_button "Log in"
            end

            scenario 'fails to login' do
              expect(page).to have_text "Email or password was incorrect."
            end
          end

          background do
            within(".form") do
              fill_in "Email", with: "jim@jim.com"
              fill_in "Password", with: "jimjim"
            end
            click_button "Log in"
          end

          scenario 'logs me in' do
            expect(page).to have_text "You are now logged in."
            expect(page).not_to have_text "Admin"
          end

        end
      end
    end
  end
end
