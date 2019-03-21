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
    student = Student.new(hash[:name], hash[:grade])
    student.save
    student
  end

  def save
    sql = <<-SQL
      INSERT INTO students (name, grade) VALUES (?,?)
    SQL
    DB[:conn].execute(sql, self.name, self.grade)

    sql = <<-SQL
      SELECT id FROM students WHERE name = (?)
    SQL
    @id = DB[:conn].execute(sql, self.name).flatten.first
  end

end #end of Class
