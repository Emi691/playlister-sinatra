class SongsController < ApplicationController

    get '/songs' do
        @songs = Song.all
        erb :"songs/index" 
    end

    get '/songs/new' do
        erb :"songs/new"
    end

    post '/songs' do
        @song = Song.create(params[:song])
        #binding.pry
        @genre = Genre.find_by(id: params[:genres])
        @song.genres << @genre
        @song.save
        if @artist = Artist.find_by(name: params[:artist][:name])
            @song.artist = @artist
            @song.save
        else
            @artist = Artist.create(params[:artist])
            @song.artist = @artist
            @song.save
         end
        redirect to "/songs/#{@song.slug}"
    end

    get '/songs/:slug' do
        @song = Song.find_by_slug(params[:slug])
        @artist = @song.artist
        @genres = @song.genres
        erb :"songs/show"
    end


end