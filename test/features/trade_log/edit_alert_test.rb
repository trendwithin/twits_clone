require "test_helper"

feature "Admin User Can Update A Trade Alert" do
  before do
    @user = users(:vic)
    logged_in_as @user
  end

  scenario "HP: Minimal Information For Successful Update" do
    visit trade_logs_path
    page.must_have_content 'GOOG'
    within('tr', text: 'GOOG') { click_link 'Edit' }
    fill_in 'Position size', with: 200
    click_button 'Update Trade log'
    page.must_have_content 'Trade log was successfully updated.'
    page.must_have_content 200
  end

  scenario "UHP: Blank Out Minimal Information For Valid Record" do
    visit edit_trade_log_path trade_logs(:one)
    fill_in 'Symbol', with: ''
    fill_in 'Position size', with: ''
    fill_in 'Entry price', with: ''
    click_button 'Update Trade log'
    page.must_have_content '4 errors prohibited'
  end
end

feature "Registerd User Can Not Update Trade Log" do
  scenario "User attempts access to Update a Record" do
    logged_in_as users(:shane)
    visit edit_trade_log_path trade_logs(:one)
    page.must_have_content 'Something Went Wrong. Contact Admin if you believe this an error'
  end
end

feature 'Site Visitor Attempts to Access Update' do
  scenario 'Attempt to access the URL for and Update' do
    visit edit_trade_log_path trade_logs(:one)
    page.must_have_content 'Something Went Wrong. Contact Admin if you believe this an error'
  end
end
