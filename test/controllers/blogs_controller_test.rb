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
    skip('Rerturn to this when there is a policy redirect path established')
    sign_in users(:shane)
    assert_raises(Pundit::NotAuthorizedError) { post :create, blog: { body: blog.body, title: blog.title } }
  end

  def test_create_not_allowed_for_site_visitors
    skip('Rerturn to this when there is a policy redirect path established')
    assert_raises(Pundit::NotAuthorizedError) { post :create, blog: { body: blog.body, title: blog.title } }
  end

  def test_show_allowed_for_admin_user
    sign_in users(:vic)
    get :show, id: blog
    assert_response :success
  end

  def test_edit_allowed_for_admin_user
    sign_in users(:vic)
    get :edit, id: blog
    assert_response :success
  end

  def test_edit_not_allowed_for_registered_users
    sign_in users(:shane)
    assert_raises(Pundit::NotAuthorizedError) { get :edit, id: blog }
  end

  def test_edit_not_allowed_for_site_visitors
    assert_raises(Pundit::NotAuthorizedError) { get :edit, id: blog }
  end

  def test_update_of_blog_post_allowed_for_admin
    sign_in users(:vic)
    put :update, id: blog, blog: { body: blog.body, title: blog.title }
    assert_redirected_to blog_path(assigns(:blog))
  end

  def test_update_of_blog_post_not_allowed_for_registered_users
    sign_in users(:shane)
    assert_raises(Pundit::NotAuthorizedError) { put :update, id: blog, blog: { body: blog.body, title: blog.title } }
  end

  def test_update_of_blog_post_not_allowed_for_site_visitors
    assert_raises(Pundit::NotAuthorizedError) { put :update, id: blog, blog: { body: blog.body, title: blog.title } }
  end

  def test_destroy_of_blog_post_allowed_for_admin
    sign_in users(:vic)
    assert_difference("Blog.count", -1) do
      delete :destroy, id: blog
    end

    assert_redirected_to blogs_path
  end

  def test_destroy_of_blog_post_not_allowed_for_registered_user
    sign_in users(:shane)
    assert_raises(Pundit::NotAuthorizedError) { delete :destroy, id: blog }
  end

  def test_destroy_of_blog_post_not_allowed_for_site_visitors
    sign_in users(:shane)
    assert_raises(Pundit::NotAuthorizedError) { delete :destroy, id: blog }
  end

end
