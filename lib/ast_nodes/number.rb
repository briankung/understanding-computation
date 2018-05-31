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

  module_function

  def Number(value)
    Number.new(value)
  end
end