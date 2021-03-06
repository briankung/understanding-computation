module ASTNodes
  class Boolean < Struct.new(:value)
    def to_s
      value.to_s
    end

    def inspect
      "«#{self}»"
    end

    def reducible?
      false
    end

    # Big step

    def evaluate(environment)
      self
    end

    # Denotational semantics

    def to_js
      "(e) => { return #{value.inspect} }"
    end

    def to_ruby
      "->(e) { #{value.inspect} }"
    end
  end

  module_function

  def Boolean(value)
    Boolean.new(value)
  end
end
