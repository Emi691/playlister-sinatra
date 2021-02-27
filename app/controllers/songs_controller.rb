require 'rack-flash'
class SongsController < ApplicationController
    enable :sessions
    use Rack::Flash

    get '/songs' do
        @songs = Song.all
        erb :"songs/index" 
    end

    get '/songs/new' do
        erb :"songs/new"
    end

    post '/songs' do
        @song = Song.create(params[:song])
        @genre = Genre.find_by(id: params[:genre])
            @song.genres << @genre
        @artist = Artist.find_or_create_by(params[:artist])
            @song.artist = @artist
        @song.save
        flash[:message] = "Successfully created song."
        redirect to "/songs/#{@song.slug}"
    end

    get '/songs/:slug' do
        @song = Song.find_by_slug(params[:slug])
        @artist = @song.artist
        @genres = @song.genres
        erb :"songs/show"
    end

    get '/songs/:slug/edit' do
        @song = Song.find_by_slug(params[:slug])
        erb :"songs/edit"
    end

    patch '/songs/:slug' do
        @song = Song.find_by_slug(params[:slug])
        @song.update(params[:song])
        @genre = Genre.find_by(id: params[:genre])
            @song.genres << @genre
        @artist = Artist.find_or_create_by(params[:artist])
            @song.artist = @artist
        @song.save
        flash[:message] = "Successfully updated song."
        redirect to "/songs/#{@song.slug}"
    end

end