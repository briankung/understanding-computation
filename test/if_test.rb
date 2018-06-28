describe If do
  before do
    @statement = If(
      Boolean(true),
      Assign(:y, 2),
      Assign(:y, 3)
    )
  end

  describe '#reducible' do
    it 'is reducible' do
      assert @statement.reducible?
    end
  end

  describe '#reduce' do
    describe "when condition is true" do
      it "reduces to consequence" do
        statement, _ = @statement.reduce({})
        assert statement == Assign(:y, 2)
      end
    end

    describe "when condition is false" do
      it "reduces to consequence" do
        @statement.condition = Boolean(false)
        statement, _ = @statement.reduce({})
        assert statement == Assign(:y, 3)
      end
    end
  end
end
