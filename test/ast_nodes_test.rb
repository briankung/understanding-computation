require_relative '../lib/ast_nodes'

include ASTNodes

describe 'Understanding Computation' do
  it 'constructs an abstract syntax tree' do
    Add(
      Multiply(Number(1), Number(2)),
      Multiply(Number(3), Number(4))
    )
  end

  it 'prints inspect with guillemets' do
    assert_output(/«5»/) {
      puts Number(5).inspect
    }
  end

  describe '#reducible' do
    describe Number do
      it 'is not reducible' do
        refute Number(5).reducible?
      end
    end

    describe Add do
      it 'is reducible' do
        assert Add(Number(1), Number(2)).reducible?
      end
    end

    describe Multiply do
      it 'is reducible' do
        assert Multiply(Number(1), Number(2)).reducible?
      end
    end
  end

  describe '#reduce' do
    before do
      @node = Add(
        Multiply(Number(1), Number(2)),
        Multiply(Number(3), Number(4))
      )
    end

    it 'reduces the left side first' do
      reduced = Add(
        Number(2),
        Multiply(Number(3), Number(4))
      )

      assert_equal reduced, @node.reduce
    end

    it 'reduces both sides after two steps' do
      reduced = Add(
        Number(2),
        Number(12)
      )

      @node = @node.reduce

      assert_equal reduced, @node.reduce
    end
  end
end
