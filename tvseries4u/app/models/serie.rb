class Serie < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :nombre, presence: true, length: { maximum:60 }
end
