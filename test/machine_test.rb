require_relative '../lib/machine'

describe Machine do
  before do
    @expression = Add(
      Multiply(Number(1), Number(2)),
      Multiply(Number(3), Number(4))
    )
    @environment = { x: Number(3), y: Number(4) }
    @vm = Machine(@expression, @environment)
  end

  describe '#step' do
    it 'calls #reduce on the given expression' do
      @expression = Minitest::Mock.new
      @expression.expect :reduce, nil
      @vm.step
    end
  end

  describe "#run" do
    it 'calls #reduce on the given expression until it no longer can' do
      assert_output(/14/) { @vm.run }
    end

    describe 'with Booleans' do
      it 'reduces to a boolean' do
        expression = LessThan(Number(5), Add(Number(2), Number(2)))
        @vm = Machine(expression, {})

        assert_output(/false/) { @vm.run }
      end
    end

    describe 'with Variables' do
      it 'reduces' do
        expression = Add(Variable(:x), Variable(:y))
        env = { x: Number(3), y: Number(4) }
        @vm = Machine(expression, env)

        assert_output(/3 \+ 4/) { @vm.run }
      end
    end

    describe 'with Assignment' do
      it "reduces" do
        statement = Assign(:x, Add(Variable(:x), Number(1)))
        environment = { x: Number(2) }
        @vm = Machine(statement, environment)

        assert_output(/do-nothing/) { @vm.run }
        assert @vm.environment = { x: Number(3) }
      end
    end

    describe 'with If' do
      before do
        @statement = If(
          Variable(:x),
          Assign(:y, Number(2)),
          Assign(:y, Number(3))
        )

        @env = { x: Boolean(true) }

        @vm = Machine(@statement, @env)
      end

      describe "when condition is true" do
        it "reduces" do
          # This next line isn't strictly necessary, it just makes the test output prettier
          assert_output(/do-nothing/) { @vm.run }
          assert @vm.environment.fetch(:y) == Number(2)
        end
      end

      describe "when condition is false" do
        it "reduces" do
          @env[:x] = Boolean(false)

          assert_output(/do-nothing/) { @vm.run }
          assert @vm.environment.fetch(:y) == Number(3)
        end
      end
    end
  end
end
