class Gender < ApplicationRecord
  belongs_to :user
  has_many :movies
end
