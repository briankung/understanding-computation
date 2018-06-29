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
        Number(left.value + right.value)
      end
    end

    # Big step

    def evaluate(environment)
      Number(left.evaluate(environment).value + right.evaluate(environment).value)
    end

    # Denotational semantics

    def to_ruby
      "->(e) { (#{left.to_ruby}).call(e) + (#{right.to_ruby}).call(e) }"
    end

    def to_js
      "(e) => { return (#{left.to_js}).call(null, e) + (#{right.to_js}).call(null, e) }"
    end
  end

  module_function

  def Add(left, right)
    Add.new(left, right)
  end
end
