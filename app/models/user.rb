class User < ActiveRecord::Base 
    has_secure_password
    has_many :user_game
    has_many :games, through: :user_game
end