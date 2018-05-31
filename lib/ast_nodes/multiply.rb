module ASTNodes
  class Multiply < Struct.new(:left, :right)
    def to_s
      "#{left} * #{right}"
    end

    def inspect
      "«#{self}»"
    end

    def reducible?
      true
    end

    def reduce
      if left.reducible?
        Multiply(left.reduce, right)
      elsif right.reducible?
        Multiply(left, right.reduce)
      else
        Number.new(left.value * right.value)
      end
    end
  end

  module_function

  def Multiply(left, right)
    Multiply.new(left, right)
  end
end
