require_relative '../lib/machine'

describe Machine do
  before do
    @expression = Add(
      Multiply(Number(1), Number(2)),
      Multiply(Number(3), Number(4))
    )
    @vm = Machine.new(@expression)
  end

  describe '#step' do
    it 'calls #reduce on the given expression' do
      @expression = Minitest::Mock.new
      @expression.expect :reduce, nil
      @vm.step
    end

    it 'calls #reduce on the given expression until it no longer can' do
      assert_output(/14/) { @vm.run }
    end

    describe 'with Booleans' do
      it 'reduces to a boolean' do
        expression = LessThan(Number(5), Add(Number(2), Number(2)))
        @vm = Machine.new(expression)
        assert_output(/false/) { @vm.run }
      end
    end
  end
end
