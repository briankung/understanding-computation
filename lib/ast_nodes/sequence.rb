module ASTNodes
  class Sequence < Struct.new(:first, :second)
    def to_s
      "#{first}, #{second}"
    end

    def inspect
      "«#{self}»"
    end

    def reducible?
      true
    end

    def reduce(environment)
      case first
      when DoNothing
        [second, environment]
      else
        reduced_first, reduced_environment = first.reduce(environment)
        [Sequence(reduced_first, second), reduced_environment]
      end
    end

    # Big step

    def evaluate(environment)
      second.evaluate(first.evaluate(environment))
    end
  end

  module_function

  def Sequence(first, second)
    Sequence.new(first, second)
  end
end
