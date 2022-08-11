require "spec_helper"
require "rack/test"
require_relative '../../app'
require "album_repository"
require "artist_repository"

describe Application do

  include Rack::Test::Methods

  let(:app) { Application.new }


  context 'GET /albums' do
    it 'should return a list of all albums' do
      response = get('/albums')


      expect(response.status).to eq 200
      expect(response.body).to include('<a href="/albums/2">Surfer Rosa</a>')
      expect(response.body).to include('<a href="/albums/3">Waterloo</a>')
      expect(response.body).to include('<a href="/albums/4">Super Trouper</a>')
    end
  end

  context "GET /albums/new" do
    it 'returns the form page for adding an album' do
      response = get('/albums/new')

      expect(response.status).to eq 200
      expect(response.body).to include('<form action="/albums" method="POST">')
      expect(response.body).to include('<input type="text" name="title">')
      expect(response.body).to include('<input type="text" name="release_year">')
      expect(response.body).to include('<input type="text" name="artist_id">')
      expect(response.body).to include('<input type="submit" value="Submit the form">')
    end
  end

  context "POST /albums" do
    it "responds with 400 error status if parameters are invalid" do
      response = post(
        '/albums',
        title: '1989',
        release_year: '',
        artist_id: 1
      )
      expect(response.status).to eq 400
      expect(response.body).to include('Please complete every box')
    end

    it 'creates a new album' do
      response = post(
        '/albums',
        title: '1989',
        release_year: '2017',
        artist_id: '3'
      )

      expect(response.status).to eq 200
      expect(response.body).to include('<p>Your album has been added!</p>')
    end
  end

  context 'GET /artists' do
    it "should return a list of artists" do
      response = get('/artists')

      expect(response.status).to eq 200
      expect(response.body).to include('<a href="/artists/2">ABBA</a>')
      expect(response.body).to include('<a href="/artists/3">Taylor Swift</a>')
      expect(response.body).to include('<a href="/artists/4">Nina Simone</a>')
    end
  end

  context 'GET /artists/new' do
    it "returns the form page for adding an artist" do
      response = get('/artists/new')

      expect(response.status).to eq 200
      expect(response.body).to include('<form action="/artists" method="POST">')
      expect(response.body).to include('<input type="text" name="name">')
      expect(response.body).to include('<input type="text" name="genre">')
      expect(response.body).to include('<input type="submit" value="Submit the form">')
    end
  end

  context "POST /artists" do
    it "responds with 400 error status if parameters are invalid" do
      response = post(
        '/artists',
        name: 'Sophie',
        genre: ""
      )
      expect(response.status).to eq 400
      expect(response.body).to include('Please complete every box')
    end

    it "creates a new artist" do
      response = post(
        '/artists',
        name: 'Sophie',
        genre: 'Pop'
      )

      expect(response.status).to eq 200
      expect(response.body).to include('<p>Your artist has been added!</p>')
    end
  end

  context "GET to /" do
    it 'contains a h1 title' do
      response = get('/')
  
      expect(response.body).to include('<h1>Hello</h1>')
    end
    
    it 'contains a div' do
      response = get('/')
  
      expect(response.body).to include('<div>')
    end
  end


  context "GET /albums/:id" do
    it "returns information of a single album with id 2" do
      response = get('/albums/2')

      expect(response.status).to eq 200
      expect(response.body).to include('<h1>Surfer Rosa</h1>')
      expect(response.body).to include('Release year: 1988')
      expect(response.body).to include('Artist: Pixies')
    end
  end

  context "GET /artists/:id" do
    it "returns information of a single artist with id 2" do
      response = get('/artists/2')

      expect(response.status).to eq 200
      expect(response.body).to include('<h1>ABBA</h1>')
      expect(response.body).to include('Genre: Pop')
    end
  end
end
