class Movie < ApplicationRecord
  belongs_to :user

  has_many :comments
  has_many :seasons


  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 140 }

end
