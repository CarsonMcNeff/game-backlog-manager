class User < ActiveRecord::Base 
    has_many :game_user 
    has_many :games, through: :game_user
end