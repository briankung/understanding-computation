require 'ostruct'

module ASTNodes
  module_function

  def Number(value)
    OpenStruct.new(value: value)
  end

  def Add(left, right)
    OpenStruct.new(left: left, right: right)
  end

  def Multiply(left, right)
    OpenStruct.new(left: left, right: right)
  end
end
