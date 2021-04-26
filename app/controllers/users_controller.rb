class UsersController < ApplicationController
    get '/user/signup' do 
        erb :'users/signup'
    end

    post '/user/signup' do 
        if params[:username] == "" || params[:password] == ""
            redirect '/user/signup'
        else  
            User.create(username: params[:username], password: params[:password])
            redirect '/user/login'
        end 
    end

    get '/user/login' do 
        erb :'users/login'
    end

    post '/user/login' do
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect "/user/#{@user.id}/gameslist" 
        else
            redirect '/user/login'
        end
    end

    get '/user/logout' do
        session.clear 
        redirect to '/'
    end

    get '/user/:id' do 
        @user = User.find(session[:user_id])
        redirect "/user/#{@user.id}/gameslist"
    end

    get '/user/:id/gameslist' do 
        @user = User.find(session[:user_id])
        @users_games = @user.users_games
        erb :'users/games_list'
    end

    get '/user/:id/gameslist/new' do 
        @user = User.find(session[:user_id])
        erb :'users/add_game'
    end
    
    post '/user/:id/gameslist/new' do 
        @user = User.find(session[:user_id])
        
        if @user.games.all.collect{|game|game.name}.include?(params["name"])
            redirect "/user/#{@user.id}/gameslist/new"
        elsif Game.find_by(name: params["name"]) && params["name"] != ""
            @game = Game.find_by(name: params["name"])
        elsif params["name"] != ""
            @game = Game.create(name: params["name"])
        else  
            redirect "/user/#{@user.id}/gameslist/new"
        end
        @user.games << @game
        @user.save
        @users_game = UsersGame.find_by(user_id: @user.id, game_id: @game.id)
        @users_game.notes = params[:notes]
        @users_game.completion_time = params[:completion_time]
        @users_game.save
        redirect "/user/#{@user.id}/gameslist"
    end

    get '/user/:id/gameslist/edit' do 

    end
end