class Chirp < ActiveRecord::Base
  belongs_to :user
  validates :content, presence: true, length: { maximum: 1000 }
  validates :user_id, presence: true

  scope :latest, -> { order(created_at: :desc) }
end
