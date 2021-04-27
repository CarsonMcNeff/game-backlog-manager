class GamesController < ApplicationController
    get '/game/:id' do
        @game = Game.find_by_id(params[:id])
        @user_games = UsersGame.all.filter{|user_game|user_game.game_id==@game.id}
        @completed_users = @user_games.filter{|user_game|user_game.completed == true}
        @average_completion_time = @completed_users.collect{|user_game|user_game.completion_time}.sum
        @average_rating = @completed_users.collect{|user_game|user_game.personal_rating}.sum / @completed_users.collect{|user_game|user_game.personal_rating}.size
        erb :'games/show'
    end

    get '/game/:id/reviews' do 
        @game = Game.find_by_id(params[:id])
        @completed_users = UsersGame.all.filter{|user_game|user_game.game_id==@game.id && user_game.completed == true}
        erb :'games/reviews'
    end
end