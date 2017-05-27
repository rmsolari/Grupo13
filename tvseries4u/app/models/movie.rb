class Movie < ApplicationRecord
  belongs_to :user

  belongs_to :gender
  has_many :comments

  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 140 }

end
