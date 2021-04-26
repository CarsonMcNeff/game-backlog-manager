class User < ActiveRecord::Base 
    has_secure_password
    has_many :users_games
    has_many :games, through: :users_games
end