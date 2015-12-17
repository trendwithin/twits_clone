class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :blogs

  validates :email, presence: true, length: { in: 5..80 }
  validates :name, length: { maximum: 50 }

  def admin?
    role == 'admin'
  end
end