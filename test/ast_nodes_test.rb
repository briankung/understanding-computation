require_relative '../lib/ast_nodes'

include ASTNodes

describe 'Understanding Computation' do
  it 'constructs an abstract syntax tree' do
    Add(
      Multiply(Number(1), Number(2)),
      Multiply(Number(3), Number(4))
    )
  end
end
