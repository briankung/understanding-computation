require 'ostruct'

module ASTNodes
  class Number < Struct.new(:value)
    def to_s
      value.to_s
    end

    def inspect
      "«#{self}»"
    end

    def reducible?
      false
    end
  end

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

    def reduce
      if left.reducible?
        Add(left.reduce, right)
      elsif right.reducible?
        Add(left, right.reduce)
      else
        Number.new(left.value + right.value)
      end
    end
  end

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

  # Module functions to make shit pretty
  module_function

  def Number(value)
    Number.new(value)
  end

  def Add(left, right)
    Add.new(left, right)
  end

  def Multiply(left, right)
    Multiply.new(left, right)
  end
end
