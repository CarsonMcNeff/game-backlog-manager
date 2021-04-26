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
        @users_games = UsersGame.all.filter{|x|x.user_id == @user.id}
        erb :'users/games_list'
    end

    get '/user/:id/gameslist/new' do 
        @user = User.find(session[:user_id])
        erb :'users/add_game'
    end
    
    post '/user/:id/gameslist/new' do 
        @user = User.find(session[:user_id])
        # Checks if the game is already in the database and if it isn't adds it, if a user
        # accidently tries to add a game that already exists in the database it just uses the
        # copy from the database
        if params["NewGame"] != "" && params["Game"] == "" && Game.find_by(name: params["NewGame"]) == nil
            @game = Game.create(name: params["NewGame"])
        elsif params["Game"] != "" && params["NewGame"] == ""
            @game = Game.find_by(name: params["Game"])
        elsif Game.find_by(name: params["NewGame"])
            @game = Game.find_by(name: params["NewGame"])
        else  
            redirect "/user/#{@user.id}/gameslist/new"
        end 
        @user.games << @game
        @user.save
        redirect "/user/#{@user.id}/gameslist"
    end

    get '/user/:id/gameslist/edit' do 

    end
end