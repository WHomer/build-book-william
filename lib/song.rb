class Song
  attr_reader :id

  def initialize(id, artist, title)
    @id = id
    @artist = artist
    @title = title
  end

  def to_json
    {
      id: @id,
      artist: @artist,
      title: @title
    }
  end
end