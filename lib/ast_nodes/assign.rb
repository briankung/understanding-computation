module ASTNodes
  class Assign < Struct.new(:name, :expression)
    def to_s
      'do-nothing'
    end

    def inspect
      "«#{self}»"
    end

    def reducible?
      true
    end

    def reduce(environment)
      if expression.reducible?
        [Assign(name, expression.reduce(environment)), environment]
      else
        [DoNothing(), environment.merge(name => expression)]
      end
    end

    # Big step

    def evaluate(environment)
      environment.merge(name => expression.evaluate(environment))
    end
  end

  module_function

  def Assign(name, expression)
    Assign.new name, expression
  end
end
