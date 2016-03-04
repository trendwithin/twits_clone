class Blog < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: { maximum: 50 }
  validates :body, presence: true, length: { maximum: 5000 }

  enum status: { pay_wall_blog: 0, public_blog: 1 }
end
