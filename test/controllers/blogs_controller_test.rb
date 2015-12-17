require "test_helper"

class BlogsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def blog
    @blog ||= blogs :one
  end

  def test_index_for_admin_user
    sign_in users(:vic)
    get :index
    assert_response :success
    assert_not_nil assigns(:blogs)
  end

  def test_index_for_registered_user
    sign_in users(:shane)
    get :index
    assert_response :success
    assert_not_nil assigns(:blogs)
  end

  def test_guest_can_not_view_index
    get :index
    assert_response 302
  end

  def test_new_allowed_for_admin_user
    sign_in users(:vic)
    get :new
    assert_response :success
  end

  def test_new_not_allowed_for_registered_user
    sign_in (:vic)
    get :new
    assert_response 302
  end

  def test_new_not_allowed_for_guest
    get :new
    assert_response 302
  end

  def test_create_allowed_for_admin_user
    sign_in users(:vic)
    assert_difference("Blog.count") do
      post :create, blog: { body: blog.body, title: blog.title }
    end

    assert_redirected_to blog_path(assigns(:blog))
  end

  def test_create_not_allowed_for_registered_users
    sign_in users(:shane)
    blog_count = Blog.all.count
    post :create, blog: { body: blog.body, title: blog.title }
    assert_redirected_to root_path || request.referrer
    assert_equal blog_count, Blog.all.count
  end

  def test_create_not_allowed_for_site_visitors
    blog_count = Blog.all.count
    post :create, blog: { body: blog.body, title: blog.title }
    assert_redirected_to new_user_session_path
    assert_equal blog_count, Blog.all.count
  end

  def test_show_allowed_for_admin_user
    sign_in users(:vic)
    get :show, id: blog
    assert_response :success
  end

  def test_show_allowed_for_registered_users
    sign_in users(:shane)
    get :show, id: blog
    assert_response :success
  end

  def test_show_is_not_allowed_for_site_visitors
    get :show, id: blog
    assert_redirected_to root_path || request.referrer
  end

  def test_edit_allowed_for_admin_user
    sign_in users(:vic)
    get :edit, id: blog
    assert_response :success
  end

  def test_edit_not_allowed_for_registered_users
    sign_in users(:shane)
    get :edit, id: blog
    assert_redirected_to root_path || request.referrer
  end

  def test_edit_not_allowed_for_site_visitors
    get :edit, id: blog
    assert_redirected_to root_path || request.referrer
  end

  def test_update_of_blog_post_allowed_for_admin
    sign_in users(:vic)
    put :update, id: blog, blog: { body: blog.body, title: blog.title }
    assert_redirected_to blog_path(assigns(:blog))
  end

  def test_update_of_blog_post_not_allowed_for_registered_users
    sign_in users(:shane)
    put :update, id: blog, blog: { body: blog.body, title: blog.title }
    assert_redirected_to root_path || request.referrer
  end

  def test_update_of_blog_post_not_allowed_for_site_visitors
    put :update, id: blog, blog: { body: blog.body, title: blog.title }
    assert_redirected_to root_path || request.refferer
  end

  def test_destroy_of_blog_post_allowed_for_admin
    sign_in users(:vic)
    assert_difference("Blog.count", -1) do
      delete :destroy, id: blog
    end

    assert_redirected_to blogs_path
  end

  def test_destroy_of_blog_post_not_allowed_for_registered_user
    blog_count = Blog.all.count
    sign_in users(:shane)
    delete :destroy, id: blog
    assert_redirected_to root_path || request.refferer
    assert_equal blog_count, Blog.all.count
  end

  def test_destroy_of_blog_post_not_allowed_for_site_visitors
    blog_count = Blog.all.count
    delete :destroy, id: blog
    assert_redirected_to root_path || request.refferer
    assert_equal blog_count, Blog.all.count
  end

end
