require "test_helper"

feature "Admin User Can Create Trade Log" do
  before do
    logged_in_as users(:vic)
  end

  scenario "Minimal Valid Data for Successful Creation of Trade Log Entry" do
    visit new_trade_log_path
    page.must_have_content "New Trade Log"
    fill_in 'Trade opened at', with: '2015-12-25'
    fill_in 'Symbol', with: 'GOOG'
    fill_in 'Position size', with: 100
    fill_in 'Entry price', with: 759.87
    click_button 'Create Trade log'
    page.must_have_content 'Trade log was successfully created.'
    page.must_have_content 'GOOG'
    page.must_have_content 100
  end

  scenario 'UHP: Trade Log Entry Open Date Empty' do
    visit new_trade_log_path
    fill_in 'Symbol', with: 'GOOG'
    fill_in 'Position size', with: 100
    fill_in 'Entry price', with: 759.87
    click_button 'Create Trade log'
    page.must_have_content '1 error prohibited'
  end

  scenario 'UHP: Trade Log Entry Symbol Empty' do
    visit new_trade_log_path
    fill_in 'Trade opened at', with: '2015-12-25'
    fill_in 'Position size', with: 100
    fill_in 'Entry price', with: 759.87
    click_button 'Create Trade log'
    page.must_have_content '1 error prohibited'
  end

  scenario 'UHP: Trade Log Entry Position Size Empty' do
    visit new_trade_log_path
    fill_in 'Trade opened at', with: '2015-12-25'
    fill_in 'Symbol', with: 'GOOG'
    fill_in 'Entry price', with: 759.87
    click_button 'Create Trade log'
    page.must_have_content '2 errors prohibited'
  end

  scenario 'UHP: Trade Log Entry Poisition Size 0' do
    visit new_trade_log_path
    fill_in 'Trade opened at', with: '2015-12-25'
    fill_in 'Position size', with: 0
    fill_in 'Symbol', with: 'GOOG'
    fill_in 'Entry price', with: 759.87
    click_button 'Create Trade log'
    page.must_have_content '1 error prohibited'
  end

  scenario 'UHP: Trade Log Entry Price Empty' do
    visit new_trade_log_path
    fill_in 'Trade opened at', with: '2015-12-25'
    fill_in 'Symbol', with: 'GOOG'
    fill_in 'Position size', with: 100
    click_button 'Create Trade log'
    page.must_have_content '1 error prohibited'
  end
end

feature 'Registered and Guest Users Can Not Access Trade Log' do
  scenario 'Reigstered User Attempts To Access Trade Log' do
    logged_in_as users(:shane)
    current_page = page.current_path
    visit new_trade_log_path
    assert page.current_path != new_trade_log_path
    assert page.current_path == root_path || current_page
  end

  scenario 'Guest Visitor Attempts To Access Trade Log' do
    visit new_trade_log_path
    assert_equal page.current_path, new_user_session_path
  end
end
