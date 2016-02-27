require "test_helper"

feature "Admin User Can Update A Blog Post" do
  before do
    @user = users(:vic)
    logged_in_as @user
  end
  scenario "HP: Blog Updated with Valid" do
    visit blogs_path
    page.must_have_content 'MyString'
    page.must_have_content 'MyText'
    click_link 'Edit'
    fill_in 'Title', with: 'One'
    fill_in 'Body', with: 'Modified'
    click_on 'Update Blog'
    page.must_have_content 'One'
    page.must_have_content 'Modified'
  end

  scenario 'HP: Admin Goes Directly To Blog URl' do
    visit edit_blog_path blogs(:one)
    page.must_have_content 'Editing Blog'
  end

  scenario 'UHP: Blog Updated with Incomplete Fields' do
    visit blogs_path
    click_link 'Edit'
    fill_in 'Title', with: ''
    fill_in 'Body', with: ''
    click_on 'Update Blog'
    page.must_have_content '2 errors prohibited this blog from being saved:'
  end

  scenario 'UHP: Blog Updated with Data Exceeding Valiations' do
    visit blogs_path
    click_on 'Edit'
    fill_in 'Title', with: 'a' * 51
    fill_in 'Body', with: 'a' * 5001
    click_on 'Update Blog'
    page.must_have_content '2 errors prohibited this blog from being saved:'
  end
end

feature 'Registerd Users and Visitors Attempt To Edit Blog Throug Index' do
  scenario 'Registerd User Should Not Have Access To Edit' do
    logged_in_as users(:shane)
    visit blogs_path
    page.wont_have_content 'Edit'
    page.wont_have_content 'Delete'
  end

  scenario 'Registerd User Should Not Have Access To Edit Blog URL' do
    logged_in_as users(:shane)
    visit edit_blog_path blogs(:one)
    page.must_have_content 'Something Went Wrong. Contact Admin if you believe this an error'
  end

  scenario 'Guest User Should Not Have Access to Edit Blog URL' do
    visit edit_blog_path blogs(:one)
    page.must_have_content 'Something Went Wrong. Contact Admin if you believe this an error'
  end
end
