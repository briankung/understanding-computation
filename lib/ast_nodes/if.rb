module ASTNodes
  class If < Struct.new(:condition, :consequence, :alternative)
    def to_s
      "if (#{condition}) { #{consequence} } else { #{alternative} }"
    end

    def inspect
      "«#{self}»"
    end

    def reducible?
      true
    end

    def reduce(environment)
      if condition.reducible?
        [
          If(condition.reduce(environment), consequence, alternative),
          environment
        ]
      else
        case condition
        when Boolean(true)
          [ consequence, environment ]
        when Boolean(false)
          [ alternative, environment ]
        end
      end
    end

    # Big step

    def evaluate(environment)
      case condition.evaluate(environment)
      when Boolean(true)
        consequence.evaluate(environment)
      when Boolean(false)
        alternative.evaluate(environment)
      end
    end
  end

  module_function

  def If(condition, consequence, alternative)
    If.new(condition, consequence, alternative)
  end
end
