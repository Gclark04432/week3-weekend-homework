class Ticket


  attr_reader :id, :customer_id, :film_id

  def intialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id']
    @film_id = options['film_id']
  end

  def save()
    sql = "INSERT INTO tickets
    (
      customer_id,
      film_id
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@customer_id, @film_id]
    user = SqlRunner.run( sql, values ).first
    @id = user['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    locations = SqlRunner.run(sql)
    map_items(locations)
  end

  def self.map_items(tickets_data)
    return ticket_data.map { |ticket| Ticket.new( ticket ) }
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

end
