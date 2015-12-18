class TradeLog < ActiveRecord::Base
  belongs_to :user

  validates :trade_opened_at, presence: true
  validates :symbol, presence: true
  validates :position_size, presence: true, numericality: { greater_than: 0 }
  validates :entry_price, presence: true
end
