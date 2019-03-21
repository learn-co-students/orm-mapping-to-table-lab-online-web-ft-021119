class Student
  attr_accessor :name, :grade
  attr_reader :id
  @@all = []
  def initialize(name, grade, id = nil)
    @name = name
    @grade = grade
    @id = id
    @@all << self
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
        )
      SQL
      DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
      DROP TABLE students
      SQL
      DB[:conn].execute(sql)
  end

  def self.create(hash)
    binding.pry
  end

  def save
    sql = <<-SQL
      INSERT INTO students (id, name, grade) VALUES (?,?,?)
    SQL
    DB[:conn].execute(sql, 1, self.name, self.grade)
  end

end #end of Class
