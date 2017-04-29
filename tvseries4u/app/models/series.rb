class Series < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :nombre_serie, presence: true, length: {maximum: 60}
end
