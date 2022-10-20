class User
  attr_reader :id

  def initialize(id, name)
    @id = id
    @name = name
  end

  def to_json
    {
      id: @id,
      name: @name
    }
  end
end