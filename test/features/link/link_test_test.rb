require "test_helper"

feature "Link Test" do
  scenario "Nav Bar Links" do
    logged_in_as users(:vic)
    visit root_path
    click_on 'Blog'
    assert current_path == blogs_path
    click_on 'Trades'
    assert current_path == trade_logs_path
    click_on 'Timeline'
    assert current_path == timeline_path
    click_on 'Blog'
    assert current_path == blogs_path
  end
end
