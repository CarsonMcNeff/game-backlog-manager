class User < ActiveRecord::Base 
    has_secure_password
    has_many :game_user 
    has_many :games, through: :game_user
end