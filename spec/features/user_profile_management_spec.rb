require 'rails_helper'

RSpec.describe 'User Profile Management', type: :feature do
  before do
    @user = User.create(email: 'test@example.com', password: 'password123', name: 'Test User')
  end
  unique_email = "test_#{Time.now.to_i + 1}@example.com"
  context 'when updating profile' do
    it 'allows a user to update their name and password' do


      

      # Visit the sign-up page
      visit new_user_registration_path
      
      # Fill in the sign-up form
      fill_in 'Email', with: unique_email
      fill_in 'Password', with: 'password123'
      fill_in 'Password confirmation', with: 'password123'
      fill_in 'user_name', with: 'Test User'
      click_button 'Sign up'
      
      # Expect to see a success message
      expect(page).to have_content('Welcome! You have signed up successfully.')

      
      # Log in
      #visit new_user_session_path
      #save_and_open_page
      #fill_in 'email', with: unique_email
      #fill_in 'password', with: 'password123'
      #click_button 'Log in'

      # Confirm the user is logged in
      #save_and_open_page
      #expect(page).to have_content("Welcome, Test User")

      # Visit the edit profile page
      visit edit_user_registration_path

      # Debugging: Output the current page content
      #save_and_open_page

      # Update the name and password
      fill_in 'user_name', with: 'Updated Name'
      fill_in 'user_password', with: 'newpassword123'
      fill_in 'user_password_confirmation', with: 'newpassword123'
      fill_in 'user_current_password', with: 'password123'
      click_button 'Update'

      # Expect success message
      expect(page).to have_content('Your account has been updated successfully.')

      # Verify the updated name
      visit root_path
      expect(page).to have_content('Welcome, Updated Name')
    end
  end

  context 'when deleting the account' do
    it 'allows a user to delete their account' do
      # Log in
      visit new_user_session_path
      fill_in 'user_email', with: unique_email
      fill_in 'user_password', with: 'newpassword123'
      click_button 'Log in'

      # Visit the edit profile page
      visit edit_user_registration_path
      # Debugging: Output the current page content
      #save_and_open_page

      # Delete the account
      click_button 'Cancel my account'

      # Expect success message
      expect(page).to have_content('Sign Up')

      # Verify the user is deleted
      expect(User.find_by(email: unique_email)).to be_nil
    end
  end
end
