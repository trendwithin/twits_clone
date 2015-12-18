require "test_helper"

class TradeLogTest < ActiveSupport::TestCase
  def trade_log
    @trade_log ||= trade_logs(:one)
  end

  def test_valid
    assert trade_log.valid?
  end

  def test_trade_log_entry_invalid_without_traded_opened_at
    trade_log.trade_opened_at = ''
    refute trade_log.valid?
  end

  def test_trade_log_entry_invalid_without_symbol
    trade_log.symbol = ''
    refute trade_log.valid?
  end

  def test_trade_log_entry_invalid_without_position_size
    trade_log.position_size = ''
    refute trade_log.valid?
  end

  def test_trade_log_entry_size_is_greater_than_0
    trade_log.position_size = 0
    refute trade_log.valid?
  end
end
