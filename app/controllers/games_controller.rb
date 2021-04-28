class GamesController < ApplicationController
    get '/game/index' do
        erb :'games/search'
    end

    get '/game/redirect' do 
        if Game.find_by(name: params["game"]) != nil
            redirect "/game/#{Game.find_by(name: params["game"]).id}"
        else  
            redirect '/game/index'
            #TODO
            #ERROR MESSAGE
        end
    end
    
    get '/game/:id' do
        puts params[:game]
        @game = Game.find_by_id(params[:id])
        @user_games = UsersGame.all.filter{|user_game|user_game.game_id==@game.id}
        @completed_users = @user_games.filter{|user_game|user_game.completed == true}
        @average_completion_time = @completed_users.collect{|user_game|user_game.completion_time}.sum
        if @completed_users.collect{|user_game|user_game.personal_rating}.size > 0
            @average_rating = @completed_users.collect{|user_game|user_game.personal_rating}.sum / @completed_users.collect{|user_game|user_game.personal_rating}.size
        end
        erb :'games/show'
    end

    get '/game/:id/reviews' do 
        @game = Game.find_by_id(params[:id])
        @completed_users = UsersGame.all.filter{|user_game|user_game.game_id==@game.id && user_game.completed == true}
        erb :'games/reviews'
    end
end