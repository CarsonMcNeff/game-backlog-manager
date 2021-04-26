class Game < ActiveRecord::Base 
    has_many :game_user 
    has_many :users, through: :game_user
end