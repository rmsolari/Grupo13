class Movie < ApplicationRecord
  belongs_to :user
<<<<<<< HEAD
  belongs_to :gender
  has_many :comments
=======
>>>>>>> b43f8760677a64b7e6d9ce59018b4102cd3ae2e9
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 140 }

end
