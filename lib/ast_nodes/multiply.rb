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

    def reduce(environment)
      if left.reducible?
        Multiply(left.reduce(environment), right)
      elsif right.reducible?
        Multiply(left, right.reduce(environment))
      else
        Number.new(left.value * right.value)
      end
    end

    # Big step

    def evaluate(environment)
      Number(left.evaluate(environment).value * right.evaluate(environment).value)
    end

    # Denotational semantics

    def to_ruby
      "->(e) { (#{left.to_ruby}).call(e) * (#{right.to_ruby}).call(e) }"
    end

    def to_js
      "(e) => { return (#{left.to_js}).call(null, e) * (#{right.to_js}).call(null, e) }"
    end
  end

  module_function

  def Multiply(left, right)
    Multiply.new(left, right)
  end
end
