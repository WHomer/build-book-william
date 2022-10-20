require 'json'
require './lib/user'
require './lib/song'
require './lib/playlist'
require './lib/spotify'

# 1. Read and parse data to Spotify class
input_file = "input"
input_file = ARGV[0] if ARGV[0]
input = JSON.parse(File.read("#{input_file}.json"), symbolize_names: true)
spotify = Spotify.new

# create users and store them in Spotify class
input[:users].each do |input_user|
  user = User.new(input_user[:id], input_user[:name])
  spotify.add_user(user)
end

# create songs and store them in Spotify class
input[:songs].each do |input_song|
  song = Song.new(input_song[:id], input_song[:artist], input_song[:title])
  spotify.add_song(song)
end

#create playlists and store them in Spotify class
input[:playlists].each do |input_playlist|
  id = input_playlist[:id]
  user = spotify.find_user_by_id(input_playlist[:owner_id])
  playlist = Playlist.new(id, user)

  input_playlist[:song_ids].each do |ip_song_id|
    song = spotify.find_song_by_id(ip_song_id)
    playlist.add_song(song)
  end

  spotify.add_playlist(playlist)
end

# 2. Read changes json file and modify stored results in Spotify class
change_file = "change"
change_file = ARGV[1] if ARGV[1]
changes = JSON.parse(File.read("#{change_file}.json"), symbolize_names: true)

changes[:changes].each do |change|
  if change[:type] == "remove_playlist"
    playlist_id = change[:attributes][:id]
    spotify.remove_playlist_by_id(playlist_id)
  elsif change[:type] == "add_song_to_playlist"
    playlist_id = change[:attributes][:playlist_id]
    song_id = change[:attributes][:song_id]

    playlist = spotify.find_playlist_by_id(playlist_id)
    song = spotify.find_song_by_id(song_id)

    playlist.add_song(song)
  elsif change[:type] == "add_playlist"
    id = change[:attributes][:id]
    user_id = change[:attributes][:owner_id]
    user = spotify.find_user_by_id(user_id)
    playlist = Playlist.new(id, user)

    change[:attributes][:song_ids].each do |song_id|
      song = spotify.find_song_by_id(song_id)
      playlist.add_song(song)
    end

    spotify.add_playlist(playlist)
  end
end

# 3. Create output json file
output_file = "output"
output_file = ARGV[2] if ARGV[2]

File.write("#{output_file}.json", JSON.pretty_generate(spotify.to_json))
