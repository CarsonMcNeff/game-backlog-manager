require './config/environment'

class ApplicationController < Sinatra::Base
    configure do 
        set :public_folder, 'public'
        set :views, 'app/views'
        enable :sessions
        set :session_secret, "7d13d6401161e1917ecec5ed2121d8e27fbd12b6ccef8f07c226b11b1e823e8732f9a34288f2dc86bf63d91957e09037b4b1d31bacee10c0ec2de0eae9b64ce9"
    end

    get '/' do
        erb :'application/home'
    end
end