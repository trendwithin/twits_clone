class CreateTradeLogs < ActiveRecord::Migration
  def change
    create_table :trade_logs do |t|
      t.references :user, index: true, foreign_key: true
      t.datetime :trade_opened_at
      t.string :symbol
      t.integer :position_size
      t.float :entry_price
      t.float :stop
      t.float :target
      t.datetime :exit_one_on
      t.integer :exit_one_shares
      t.float :exit_one_price
      t.datetime :exit_two_on
      t.integer :exit_two_shares
      t.float :exit_two_price
      t.datetime :exit_three_on
      t.integer :exit_three_shares
      t.float :exit_three_price

      t.timestamps null: false
    end
  end
end
