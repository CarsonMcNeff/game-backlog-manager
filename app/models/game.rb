class Game < ActiveRecord::Base 
    has_many :user_game
    has_many :users, through: :user_game
end