require 'rails_helper'

RSpec.describe 'User Authentication', type: :feature do
  it 'allows a user to sign up, log out, and log back in' do
    # Generate a unique email for testing
    unique_email = "test_#{Time.now.to_i}@example.com"

    # Visit the sign-up page
    visit new_user_registration_path

    # Fill in the sign-up form
    fill_in 'Email', with: unique_email
    fill_in 'Password', with: 'password123'
    fill_in 'Password confirmation', with: 'password123'
    click_button 'Sign up'

    # Expect to see a success message and verify user is redirected
    expect(page).to have_content('Welcome! You have signed up successfully.')
    expect(page).to have_content("Welcome, #{unique_email}")

    # Log out
    click_link 'Logout'

    # Verify that the user is logged out
    expect(page).to have_content('Log In')
    expect(page).not_to have_content("Welcome, #{unique_email}")

    # Visit the login page
    visit new_user_session_path

    # Fill in the login form with the same credentials
    fill_in 'Email', with: unique_email
    fill_in 'Password', with: 'password123'
    click_button 'Log in'

    # Expect to see a logged-in message and verify user is redirected
    expect(page).to have_content('Signed in successfully.')
    expect(page).to have_content("Welcome, #{unique_email}")
  end
end
