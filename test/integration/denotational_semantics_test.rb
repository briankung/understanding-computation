describe 'denotational semantics' do
  describe Number do
    it "generates valid ruby" do
      function = Number(5).to_ruby.yield_self(&method(:eval))
      assert_equal 5, function.call({})
    end

    it "generates valid js" do
      result, err = node_exec(Number(5).to_js)
      assert_equal "5", result
    end
  end

  describe Boolean do
    it "generates valid ruby" do
      function = Boolean(false).to_ruby.yield_self(&method(:eval))
      assert_equal false, function.call({})
    end

    it "generates valid js" do
      result, err = node_exec(Boolean(false).to_js)
      assert_equal "false", result
    end
  end

  describe Variable do
    it "generates valid ruby" do
      function = Variable(:x).to_ruby.yield_self(&method(:eval))
      assert_equal 7, function.call(x: 7)
    end

    it "generates valid js" do
      result, err = node_exec(Variable(:x).to_js, x: 7)
      assert_equal "7", result
    end
  end

  describe Add do
    before { @add = Add(Variable(:x), Number(1)) }

    it "generates valid ruby" do
      function = @add.to_ruby.yield_self(&method(:eval))
      assert_equal 8, function.call(x: 7)
    end

    it "generates valid js" do
      result, err = node_exec(@add.to_js, x: 7)
      assert_equal "8", result
    end
  end

  describe Multiply do
    before { @mult = Multiply(Variable(:x), Number(10)) }

    it "generates valid ruby" do
      function = @mult.to_ruby.yield_self(&method(:eval))
      assert_equal 70, function.call(x: 7)
    end

    it "generates valid js" do
      result, err = node_exec(@mult.to_js, x: 7)
      assert_equal "70", result
    end
  end
end
