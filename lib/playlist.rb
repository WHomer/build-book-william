class Playlist
  attr_reader :id

  def initialize(id, owner)
    @id = id
    @owner = owner
    @songs = []
  end

  def add_song(song)
    @songs << song
  end

  def to_json
    {
      id: @id,
      owner_id: @owner.id,
      song_ids: @songs.map(&:id)
    }
  end
end