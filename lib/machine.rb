class Machine < Struct.new(:statement, :environment)
  def step
    self.statement, step_environment = statement.reduce(environment)

    # Patch for Add, LessThan, etc. not returning environment:
    self.environment = step_environment || self.environment
  end

  def run
    while statement.reducible?
      puts "#{statement}, #{environment}"
      step
    end

    puts "#{statement}, #{environment}"
  end
end

def Machine(statement, environment)
  Machine.new(statement, environment)
end
