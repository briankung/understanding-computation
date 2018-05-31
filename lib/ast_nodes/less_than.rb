module ASTNodes
  class LessThan < Struct.new(:left, :right)
    def to_s
      "#{left} < #{right}"
    end

    def inspect
      "«#{self}»"
    end

    def reducible?
      true
    end

    def reduce(environment)
      if left.reducible?
        LessThan(left.reduce(environment), right)
      elsif right.reducible?
        LessThan(left, right.reduce(environment))
      else
        Boolean(left.value < right.value)
      end
    end
  end

  module_function

  def LessThan(left, right)
    LessThan.new(left, right)
  end
end
