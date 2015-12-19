require "test_helper"

feature "Admin Can Delete A Trade Alert" do
  scenario "Alert Exists And Deletes" do
    logged_in_as users(:vic)
    visit trade_logs_path
    within('tr', text: 'GOOG') { click_link 'Destroy' }
    visit trade_logs_path
    page.wont_have_content 'GOOG'
  end
end
