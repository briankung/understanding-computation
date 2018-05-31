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

  module_function

  def Add(left, right)
    Add.new(left, right)
  end
end
