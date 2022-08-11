require_relative 'artist'

class ArtistRepository
  def all
    artists = []

    sql = 'SELECT id, name, genre FROM artists;'
    result_set = DatabaseConnection.exec_params(sql, [])

    result_set.each do |record|

      artist = Artist.new
      artist.id = record['id'].to_i
      artist.name = record['name']
      artist.genre = record['genre']

      artists << artist
    end
    return artists
  end

  def find(id)
    sql = 'SELECT id, name, genre FROM artists WHERE id = $1;'
    result_set = DatabaseConnection.exec_params(sql, [id])
  
    artist = Artist.new
    
    result_set.each { |record|
      artist.id = record['id'].to_i
      artist.name = record['name']
      artist.genre = record['genre']
    }
    return artist
  end

  def create(artist)
    sql = 'INSERT INTO artists (name, genre) VALUES ($1, $2);'
    result_set = DatabaseConnection.exec_params(sql, [artist.name, artist.genre])

    return artist
  end
end