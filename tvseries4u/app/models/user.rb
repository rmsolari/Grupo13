  class User < ApplicationRecord
    acts_as_voter

    has_many :genders
    has_many :comments
    has_many :seasons
    has_many :niños, :class_name => 'User', :foreign_key => :adulto_id
    belongs_to :adulto, :class_name => 'User'
    has_many :movies, dependent: :destroy
    has_many :niños_movies, :through => :niños, :class_name => 'Movie', dependent: :destroy
    has_many :active_relationships, class_name:  "Relationship",
                                foreign_key: "follower_id",
                                dependent:   :destroy
    has_many :passive_relationships, class_name:  "Relationship",
                                foreign_key: "followed_id",
                                dependent:   :destroy
    has_many :followers, through: :passive_relationships, source: :follower

    has_many :following, through: :active_relationships, source: :followed
   	before_save { email.downcase! }
  	validates :name, presence: true, length: { maximum: 50 }
  	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  	validates :email, presence: true, length: { maximum: 255 },
  	format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  	has_secure_password
  	validates :password, presence: true, length: { minimum: 6 }

  def adulto?
    adulto_id.nil?
  end

  def niño?
    !adulto?
  end

  def genders_for_form
    collection = genders.where(user_id: id)
    collection.any? ? collection : genders.build
  end

	def User.digest(string)
    	cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        	                                          BCrypt::Engine.cost
    	BCrypt::Password.create(string, cost: cost)
	end

  def feed
    following_ids = "SELECT followed_id FROM relationships
                   WHERE  follower_id = :user_id"
    Movie.where("user_id IN (#{following_ids})
                   OR user_id = :user_id", user_id: id)
  end

  # Follows a user.
  def follow(other_user)
    following << other_user
  end

  # Unfollows a user.
  def unfollow(other_user)
    following.delete(other_user)
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end
end
