class Episode < ApplicationRecord
  acts_as_votable

  belongs_to :season
end
