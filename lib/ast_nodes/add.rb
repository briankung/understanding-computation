module ASTNodes
  class Add < Struct.new(:left, :right)
    def to_s
      "#{left} + #{right}"
    end

    def inspect
      "«#{self}»"
    end

    def reducible?
      true
    end

    def reduce(environment)
      if left.reducible?
        Add(left.reduce(environment), right)
      elsif right.reducible?
        Add(left, right.reduce(environment))
      else
        Number.new(left.value + right.value)
      end
    end
  end

  module_function

  def Add(left, right)
    Add.new(left, right)
  end
end
