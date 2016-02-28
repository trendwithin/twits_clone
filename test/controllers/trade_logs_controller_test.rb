require "test_helper"

class TradeLogsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def trade_log
    @trade_log ||= trade_logs :one
    # @trade_log ||= { symbol: 'NEW', position_size: 100, entry_price: 25.5, stop: 24.5, target: 27 }
  end

  def test_index
    sign_in users(:vic)
    get :index
    assert_response :success
    assert_not_nil assigns(:trade_logs)
  end

  def test_index_is_viewable_by_registerd
    sign_in users(:shane)
    get :index
    assert_response :success
  end

  def test_index_in_not_open_to_vistors
    get :index
    assert_response :redirect
  end

  def test_new
    sign_in users(:vic)
    get :new
    assert_response :success
  end

  def test_new_is_not_open_to_registerd_users
    sign_in users(:shane)
    get :new
    assert_response :redirect
  end

  def test_new_is_not_open_to_visitors
    get :new
    assert_response :redirect
  end

  def test_create
    skip
    sign_in users(:vic)
    assert_difference("TradeLog.count") do
      new_trade = { trade_opened_at: Time.now, symbol: 'SYNC', position_size: 100, entry_price: 10.00, stop: 9, target: 12.5}
      post :create, trade_log: new_trade
      # post :create, trade_log: { entry_price: trade_log.entry_price, exit_one_on: trade_log.exit_one_on, exit_one_price: trade_log.exit_one_price, exit_three_on: trade_log.exit_three_on, exit_three_price: trade_log.exit_three_price, exit_two_on: trade_log.exit_two_on, exit_two_price: trade_log.exit_two_price, position_size: trade_log.position_size, stop: trade_log.stop, symbol: trade_log.symbol, target: trade_log.target, trade_opened_at: trade_log.trade_opened_at, user_id: trade_log.user_id }
    end

    assert_redirected_to trade_log_path(assigns(:trade_log))
  end

  def test_create_is_not_open_to_registered_users
    sign_in users(:shane)
    trade_count = TradeLog.all.count
    post :create, trade_log: { entry_price: trade_log.entry_price, exit_one_on: trade_log.exit_one_on, exit_one_price: trade_log.exit_one_price, exit_three_on: trade_log.exit_three_on, exit_three_price: trade_log.exit_three_price, exit_two_on: trade_log.exit_two_on, exit_two_price: trade_log.exit_two_price, position_size: trade_log.position_size, stop: trade_log.stop, symbol: trade_log.symbol, target: trade_log.target, trade_opened_at: trade_log.trade_opened_at, user_id: trade_log.user_id }
    assert_redirected_to root_path || request.referrer
    assert_equal trade_count, TradeLog.all.count
  end

  def test_create_is_not_open_to_visitors
    trade_count = TradeLog.all.count
    post :create, trade_log: { entry_price: trade_log.entry_price, exit_one_on: trade_log.exit_one_on, exit_one_price: trade_log.exit_one_price, exit_three_on: trade_log.exit_three_on, exit_three_price: trade_log.exit_three_price, exit_two_on: trade_log.exit_two_on, exit_two_price: trade_log.exit_two_price, position_size: trade_log.position_size, stop: trade_log.stop, symbol: trade_log.symbol, target: trade_log.target, trade_opened_at: trade_log.trade_opened_at, user_id: trade_log.user_id }
    assert_redirected_to new_user_session_path
    assert_equal trade_count, TradeLog.all.count
  end

  def test_show
    sign_in users(:vic)
    get :show, id: trade_log
    assert_response :success
  end

  def test_show_available_to_registered_users
    sign_in users(:shane)
    get :show, id: trade_log
    assert_response :success
  end

  def test_show_is_not_available_to_visitors
    get :show, id: trade_log
    assert_redirected_to root_path
  end

  def test_edit
    sign_in users(:vic)
    get :edit, id: trade_log
    assert_response :success
  end

  def test_edit_is_not_open_to_registered_user
    sign_in users(:shane)
    get :edit, id: trade_log
    assert_redirected_to root_path || request.referrer
  end

  def test_edit_is_not_open_to_visitor
    get :edit, id: trade_log
    assert_redirected_to root_path || request.referrer
  end

  def test_update
    skip
    sign_in users(:vic)
    put :update, id: trade_log, trade_log: { entry_price: trade_log.entry_price, exit_one_on: trade_log.exit_one_on, exit_one_price: trade_log.exit_one_price, exit_three_on: trade_log.exit_three_on, exit_three_price: trade_log.exit_three_price, exit_two_on: trade_log.exit_two_on, exit_two_price: trade_log.exit_two_price, position_size: trade_log.position_size, stop: trade_log.stop, symbol: trade_log.symbol, target: trade_log.target, trade_opened_at: trade_log.trade_opened_at, user_id: trade_log.user_id }
    assert_redirected_to trade_log_path(assigns(:trade_log))
  end

  def test_update_not_open_to_regsterd_users
    sign_in (:shane)
    put :update, id: trade_log, trade_log: { entry_price: trade_log.entry_price, exit_one_on: trade_log.exit_one_on, exit_one_price: trade_log.exit_one_price, exit_three_on: trade_log.exit_three_on, exit_three_price: trade_log.exit_three_price, exit_two_on: trade_log.exit_two_on, exit_two_price: trade_log.exit_two_price, position_size: trade_log.position_size, stop: trade_log.stop, symbol: trade_log.symbol, target: trade_log.target, trade_opened_at: trade_log.trade_opened_at, user_id: trade_log.user_id }
    assert_redirected_to root_path || request.referrer
  end

  def test_update_not_open_to_visitors
    put :update, id: trade_log, trade_log: { entry_price: trade_log.entry_price, exit_one_on: trade_log.exit_one_on, exit_one_price: trade_log.exit_one_price, exit_three_on: trade_log.exit_three_on, exit_three_price: trade_log.exit_three_price, exit_two_on: trade_log.exit_two_on, exit_two_price: trade_log.exit_two_price, position_size: trade_log.position_size, stop: trade_log.stop, symbol: trade_log.symbol, target: trade_log.target, trade_opened_at: trade_log.trade_opened_at, user_id: trade_log.user_id }
    assert_redirected_to root_path || request.referrer
  end

  def test_destroy
    sign_in users(:vic)
    assert_difference("TradeLog.count", -1) do
      delete :destroy, id: trade_log
    end

    assert_redirected_to trade_logs_path
  end

  def test_destroy_not_open_to_registerd_users
    sign_in users(:shane)
    trade_count = TradeLog.all.count
    delete :destroy, id: trade_log
    assert_equal trade_count, TradeLog.all.count
    assert_redirected_to root_path || request.referrer
  end

  def test_destroy_not_open_to_visitor
    trade_count = TradeLog.all.count
    delete :destroy, id: trade_log
    assert_equal trade_count, TradeLog.all.count
    assert_redirected_to root_path || request.referrer
  end
end
