class UsersController < ApplicationController
    get '/user/signup' do 
        erb :'users/signup'
    end

    post '/user/signup' do 
        if params[:username] == "" || params[:password] == "" || User.all.collect{|user|user.username}.include?(params[:username])
            #TODO
            #ADD ERROR MESSAGE
            puts "dog"
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
            #TODO
            #ADD ERROR MESSAGE
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
        @users_completed_games = @users_games.filter{|game|game.completed == true}
        @users_uncompleted_games = @users_games.filter{|game|game.completed != true}
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
            #TODO
            #ADD ERROR MESSAGE
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

    patch '/user/:id/gameslist/:game_id' do 
        @user = User.find(session[:user_id])
        @users_game = UsersGame.find_by(user_id: session[:user_id], game_id: params[:game_id])
        if params["completion_time"] == "" || params["personal_rating"] == "" || params["notes"] == ""
            redirect "/user/#{@user.id}/gameslist"
            #TODO
            #ADD ERROR MESSAGE
        end
        if params["completed"] == "on"
            @users_game.completed = true
            @users_game.completion_time = params["completed_time"]
            @users_game.personal_rating = params["rating"]
        elsif   
            @users_game.completion_time = params["completion_time"]
        end 
        @users_game.notes = params["notes"]
        @users_game.save
        redirect "/user/#{session[:user_id]}/gameslist"
    end

    patch '/user/:id/gameslist/:game_id/complete' do 
        @user = User.find(session[:user_id])
        @users_game = UsersGame.find_by(user_id: session[:user_id], game_id: params[:game_id])
        if params["completion_time"] == "" || params["personal_rating"] == "" || params["notes"] == ""
            redirect "/user/#{@user.id}/gameslist"
            #TODO
            #ADD ERROR MESSAGE
        end
        @users_game.completion_time = params["completion_time"]
        @users_game.personal_rating = params["rating"]
        @users_game.notes = params["notes"]
        @users_game.save
        redirect "/user/#{session[:user_id]}/gameslist"
    end

    delete '/user/:id/gameslist/:game_id' do 
        @users_game = UsersGame.find_by(user_id: session[:user_id], game_id: params[:game_id])
        @users_game.destroy
        redirect "/user/#{session[:user_id]}/gameslist"
    end

    get '/user/:id/gameslist/:game_id/edit' do 
        @users_game = UsersGame.find_by(user_id: session[:user_id], game_id: params[:game_id])
        @user = User.find(session[:user_id])
        if @users_game.completed != true
            erb :'users/edit_game'
        else  
            erb :'users/edit_completed_game'
        end
    end

end