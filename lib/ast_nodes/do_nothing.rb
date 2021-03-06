module ASTNodes
  class DoNothing < Struct.new(nil)
    def to_s
      'do-nothing'
    end

    def inspect
      "«#{self}»"
    end

    def reducible?
      false
    end

    # Big step

    def evaluate(environment)
      environment
    end
  end

  module_function

  def DoNothing
    DoNothing.new
  end
end
