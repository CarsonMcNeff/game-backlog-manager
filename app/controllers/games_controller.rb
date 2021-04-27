class GamesController < ApplicationController
    get '/game/:id' do
        @game = Game.find_by_id(params[:id])
        erb :'games/show'
    end
end