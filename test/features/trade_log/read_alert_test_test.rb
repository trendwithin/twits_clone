require "test_helper"

feature "Admin Can Read Trade Log Index" do
  scenario "Visit Index Shows Trades" do
    logged_in_as users(:vic)
    visit trade_logs_path
    page.must_have_content "GOOG"
    page.must_have_content "AAPL"
    page.must_have_content 'Show'
    page.must_have_content 'Edit'
    page.must_have_content 'Destroy'

    within('tr', text: 'GOOG') { click_link 'Show' }
    page.must_have_content 'GOOG'
  end
end

feature "Registerd User Can Read Trade Log Index" do
  scenario 'Visit Index, Shows Trades' do
    logged_in_as users(:shane)
    visit trade_logs_path
    page.must_have_content 'GOOG'
    page.must_have_content 'AAPL'
    page.must_have_content 'Show'
    page.wont_have_content 'Edit'
    page.wont_have_content 'Destroy'

    within('tr', text: 'GOOG') { click_link 'Show' }
    page.wont_have_content 'Edit'
    page.must_have_content 'GOOG'
    assert page.current_path == trade_log_path(trade_logs(:one))
  end
end

feature 'Guest Visitors Can Not Access Log Index' do
  scenario 'Guest Tries To Use Url To Access Show' do
    visit trade_log_path(trade_logs(:one))
    page.must_have_content 'Something Went Wrong. Contact Admin if you believe this an error'
  end

  scenario 'Guest Tries To View Index' do
    visit trade_logs_path
    page.must_have_content 'You need to sign in or sign up before continuing.'
  end
end
