class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def intialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds']
  end

  def save()
    sql = "INSERT INTO customers
    (
      name,
      funds
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@name, @funds]
    user = SqlRunner.run( sql, values ).first
    @id = user['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM customers"
    locations = SqlRunner.run(sql)
    map_items(locations)
  end

  def self.map_items(customer_data)
    return customer_data.map { |customer| Customer.new( customer ) }
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

end
