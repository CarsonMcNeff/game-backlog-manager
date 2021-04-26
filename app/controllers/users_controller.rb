class UsersController < ApplicationController
    get '/user/signup' do 
        erb :'users/signup'
    end

    post '/user/signup' do 
        if params[:username] == "" || params[:password] == ""
            redirect '/user/failure'
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
            redirect "/user/#{@user.id}" 
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
        erb :'users/account_index'
    end
end