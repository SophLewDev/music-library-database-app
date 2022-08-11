require 'sinatra'
require "sinatra/reloader"
require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/artist_repository'

DatabaseConnection.connect

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/album_repository'
    also_reload 'lib/artist_repository'
  end

  get '/albums' do
    repository = AlbumRepository.new
    @albums = repository.all
    return erb(:albums)
  end

  get '/albums/new' do
    return erb(:create_album)
  end

  post '/albums' do
    if params[:title] == "" || params[:release_year] == "" || params[:artist_id] == ""
      status 400
      # return 'Please complete every box'
      @invalid_params = true
      return erb(:create_album)
    end

    title = params[:title]
    release_year = params[:release_year]
    artist_id = params[:artist_id]

    repository = AlbumRepository.new
    new_album = Album.new 
    new_album.title = title
    new_album.release_year = release_year
    new_album.artist_id = artist_id
    repository.create(new_album)

    return erb(:album_created)
  end

  get '/artists' do
    repository = ArtistRepository.new
    @artists = repository.all
    return erb(:artists)
  end

  get '/artists/new' do
    return erb(:create_artist)
  end
  post '/artists' do
    if params[:name] == "" || params[:genre] == ""
      status 400
      @invalid_params = true
      return erb(:create_artist)
    end

    name = params[:name]
    genre = params[:genre]

    repository = ArtistRepository.new
    new_artist = Artist.new
    new_artist.name = name
    new_artist.genre = genre
    repository.create(new_artist)
    return erb(:artist_created)
  end

  get '/' do
    return erb(:index)
  end

  get '/albums/:id' do
    repository = AlbumRepository.new
    artist_repository = ArtistRepository.new

    @album = repository.find(params[:id])
    @artist = artist_repository.find(@album.artist_id)
    
    return erb(:album)
  end

  get '/artists/:id' do
    repository = ArtistRepository.new

    @artist = repository.find(params[:id])

    return erb(:artist)
  end
end