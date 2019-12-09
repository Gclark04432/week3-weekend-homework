class Film

  attr_reader :id
  attr_accessor :title, :price

  def intialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price']
  end

  def save()
    sql = "INSERT INTO films
    (
      title,
      price
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@title, @price]
    user = SqlRunner.run( sql, values ).first
    @id = user['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM films"
    locations = SqlRunner.run(sql)
    map_items(locations)
  end

  def self.map_items(film_data)
    return film_data.map { |film| Film.new( film ) }
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

end
