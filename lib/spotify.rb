require './lib/user'
require './lib/song'
require './lib/playlist'

class Spotify

  def initialize
    @users = []
    @songs = []
    @playlists = []
  end

  def add_user(user)
    @users << user
  end

  def add_song(song)
    @songs << song
  end

  def add_playlist(playlist)
    @playlists << playlist
  end

  def find_user_by_id(id)
    @users.find{|user| user.id == id}
  end

  def find_song_by_id(id)
    @songs.find{|song| song.id == id}
  end
  
  def find_playlist_by_id(id)
    @playlists.find{|playlist| playlist.id == id}
  end

  def remove_playlist_by_id(id)
    @playlists.delete_if{|playlist| playlist.id == id}
  end

  def to_json
    {
      users: @users.map{|user| user.to_json},
      songs: @songs.map{|song| song.to_json},
      playlists: @playlists.map{|playlist| playlist.to_json}
    }
  end
end