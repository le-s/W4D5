require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do
  background :each do
    # visit new_user_path
    visit new_user_url
  end

  scenario 'has a new user page' do
    expect(page).to have_content("Create user page")
    expect(page).to have_content("Username")
    expect(page).to have_content("Password")
  end

  feature 'signing up a user' do
    scenario 'shows username on the homepage after signup' do
      fill_in 'Username', with: 'george'
      fill_in 'Password', with: '123456'
      click_button 'Create user!'

      expect(page).to have_content('george')
    end
  end
end

feature 'logging in' do

  background :each do
    visit new_user_url
    fill_in 'Username', with: 'george'
    fill_in 'Password', with: '123456'
    click_button 'Create user!'
    click_button 'Log out'
    visit new_session_url
  end

  scenario 'shows username on the homepage after login' do
    fill_in 'Username', with: 'george'
    fill_in 'Password', with: '123456'
    click_button 'Log In'
    # save_and_open_page
    expect(page).to have_content('george')
  end

end

feature 'logging out' do
  background :each do
    visit new_user_url
    fill_in 'Username', with: 'george'
    fill_in 'Password', with: '123456'
    click_button 'Create user!'
    click_button 'Log out'
  end

  scenario 'begins with a logged out state' do
    expect(page).to have_content("Log In")
  end

  scenario 'doesn\'t show username on the homepage after logout' do
    expect(page).not_to have_content('george')
  end

end
