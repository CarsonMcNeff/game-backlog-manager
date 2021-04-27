class GamesController < ApplicationController
    get '/game/:id' do
        @game = Game.find_by_id(params["game"])
        erb :'games/show'
    end

    delete '/game/:id' do 
        @usersgame = UsersGame.find_by(user_id: session[:user_id], game_id: params["game_id"])
        @usersgame.destroy
        redirect "/user/#{session[:user_id]}/gameslist"
    end
        
end