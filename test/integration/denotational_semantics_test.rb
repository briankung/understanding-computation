describe 'denotational semantics' do
  describe "Number" do
    it "generates valid ruby" do
      function = Number(5).to_ruby.yield_self { |code| eval(code) }
      assert_equal 5, function.call({})
    end

    it "generates valid js" do
      result = node_exec(Number(5).to_js)
      assert_equal "5", result
    end
  end

  describe "Boolean" do
    it "generates valid ruby" do
      function = Boolean(false).to_ruby.yield_self { |code| eval(code) }
      assert_equal false, function.call({})
    end

    it "generates valid js" do
      result = node_exec(Boolean(false).to_js)
      assert_equal "false", result
    end
  end
end
