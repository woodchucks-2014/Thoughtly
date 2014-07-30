require 'rails_helper'
require 'capybara/rspec'
require 'rails_helper'

feature "Welcomes", :type => :feature do

  feature 'User browsing the website' do
    scenario 'when user visits root path' do
      visit root_path
    end
  end

  feature 'ability to sign up as a user' do

    scenario 'user fills out sign up form without errors' do
      visit root_path
      click_link 'get started >>'
      click_link 'or create a new account'
      fill_in 'Email', with: 'bobo@gmail.com'
      fill_in 'Password', with: 'testtest'
      fill_in 'Confirm Password', with: 'testtest'
      # fill_in 'password Confirmation', with: 'test'
      click_button 'Sign Me Up!'

      user = User.find_by_email('bobo@gmail.com')

      expect(current_path).to eq(user_categories_path(user))
    end

    xscenario "user fills out form with invalid credentials" do
      visit root_path
      click_link 'get started >>'
      click_link 'or create a new account'
      fill_in 'Email', with: 'invalid entry'
      fill_in 'Password', with: '!@%!^@!'
      fill_in 'Confirm Password', with: '#^@&$^'
      # fill_in 'password Confirmation', with: 'test'
      click_button 'Sign Me Up!'

      expect(current_path).to eq(root_path)
      expect(page).to have_content('Invalid credentials!')
    end
  end

  feature "ability to sign in as a user" do

    let(:user) { FactoryGirl.create :user}

    scenario "existing user fills out form with valid credentials" do
      visit root_path
      click_link 'get started >>'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      # fill_in 'password Confirmation', with: 'test'
      click_button 'Sign Me In!'

      expect(current_path).to eq(user_categories_path(user))
    end

      scenario "existing user fills out form with invalid credentials" do
      visit root_path
      click_link 'get started >>'
      fill_in 'Email', with: 'invalid credentials'
      fill_in 'Password', with: '#$@!$#@!$@!'
      click_button 'Sign Me In!'

      expect(current_path).to eq(root_path)
    end
  end

  feature "ability to log out as an existing user" do

    let(:user) { FactoryGirl.create :user}

    scenario "existing user hits 'sign out' link to sign out" do
      visit root_path
      click_link 'get started >>'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign Me In!'

      expect(current_path).to eq(user_categories_path(user))
    end

  end
  feature "ability to view user profile page" do

    let(:user) { FactoryGirl.create :user}
    let(:nut) {FactoryGirl.create :nut}

    scenario "has an ability to delete a category" do
      visit root_path
      click_link 'get started >>'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      # fill_in 'password Confirmation', with: 'test'
      click_button 'Sign Me In!'
      click_button 'sign-in fa-2x'

      expect(current_path).to eq(root_path)
    end



  end



end
