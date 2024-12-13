require 'rails_helper'

RSpec.describe 'User Authentication', type: :feature do
  it 'allows a user to sign up and log in' do
    # Visit the sign-up page
    visit new_user_registration_path

    # Fill in the sign-up form
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'password123'
    fill_in 'Password confirmation', with: 'password123'
    click_button 'Sign up'

    # Expect to see a success message
    expect(page).to have_content('Welcome! You have signed up successfully.')

    # Log out
    click_link 'Logout'

    # Visit the login page
    visit new_user_session_path

    # Fill in the login form
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'password123'
    click_button 'Log in'

    # Expect to see a logged-in message
    expect(page).to have_content('Signed in successfully.')
  end
end
