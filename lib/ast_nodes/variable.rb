module ASTNodes
  class Variable < Struct.new(:name)
    def to_s
      name.to_s
    end

    def inspect
      "«#{self}»"
    end

    def reducible?
      true
    end

    def reduce(environment)
      environment[name]
    end

    # Big step

    def evaluate(environment)
      environment[name]
    end

    # Denotational semantics

    def to_ruby
      "->(e) { e[#{name.inspect}] }"
    end

    def to_js
      "(e) => { return e[#{name.to_s.inspect}] }"
    end
  end

  module_function

  def Variable(name)
    Variable.new(name)
  end
end
