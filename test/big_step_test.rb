describe 'big-step evaluation' do
  describe "Number" do
    it "evaluates self" do
      assert_equal Number(23).evaluate({}), Number(23)
    end
  end

  describe "Variable" do
    it "evaluates to the specified variable" do
      assert_equal Variable(:x).evaluate(x: Number(23)), Number(23)
    end
  end

  describe "with complex expression" do
    describe "LessThan" do
      it "evaluates to the proper boolean" do
        exp = LessThan(
          Add(Variable(:x), Number(2)),
          Variable(:y)
        )

        assert_equal exp.evaluate(x: Number(2), y: Number(5)), Boolean(true)
      end
    end

    describe "pg 46" do
      it "evaluates to a single value" do
        statement = Sequence(
          Assign(:x, Add(Number(1), Number(1))),
          Assign(:y, Add(Variable(:x), Number(3)))
        )

        assert_equal statement.evaluate({}), { x: Number(2), y: Number(5) }
      end
    end
  end
end
