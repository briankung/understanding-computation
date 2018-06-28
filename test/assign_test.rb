describe Assign do
  describe 'module functionality' do
    it "doesn't break" do
      Assign(:x, 2)
    end
  end

  describe '#reducible' do
    it 'is reducible' do
      assert Assign(:x, 2).reducible?
    end
  end

  describe "#reduce" do
    it "reduces" do
      statement = Assign(:x, Add(Variable(:x), Number(1)))
      environment = { x: Number(2) }
      statement, environment = statement.reduce(environment)

      assert statement == Assign(:x, Add(Number(2), Number(1)))
      assert environment == { x: Number(2) } # unchanged...yet

      statement, environment = statement.reduce(environment)

      assert statement == Assign(:x, Number(3))
      assert environment == { x: Number(2) }
    end

    it "changes the environment" do
      statement = Assign(:x, Number(3))
      environment = { x: Number(2) }
      statement, environment = statement.reduce(environment)

      assert statement == DoNothing()
      assert environment == { x: Number(3) }
    end
  end
end
