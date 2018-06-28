describe LessThan do
  describe '#reducible' do
    it 'is reducible' do
      assert LessThan(Number(2), Number(3)).reducible?
    end
  end

  describe '#reduce' do
    describe "when 2 < 3 ?" do
      it "reduces to true" do
        env = {}
        statement = LessThan(Number(2), Number(3)).reduce(env)
        refute statement.reducible?
        assert statement == Boolean(true)
      end
    end

    describe "when 3 < 2 ?" do
      it "reduces to false" do
        env = {}
        statement = LessThan(Number(3), Number(2)).reduce(env)
        refute statement.reducible?
        assert statement == Boolean(false)
      end
    end
  end
end
