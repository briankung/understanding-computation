module ASTNodes
  class While < Struct.new(:condition, :body)
    def to_s
      "while (#{condition}) { #{body} }"
    end

    def inspect
      "«#{self}»"
    end

    def reducible?
      true
    end

    def reduce(environment)
      [If(condition, Sequence(body, self), DoNothing()), environment]
    end
  end

  module_function

  def While(condition, body)
    While.new(condition, body)
  end
end
