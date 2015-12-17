class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.text :body
      t.string :published, default: false
      t.integer :status, default: 0 # 0 for private 1 for public
      t.references :user

      t.timestamps null: false
    end
  end
end
