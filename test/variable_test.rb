describe Variable do
  describe 'module functionality' do
    it "doesn't break" do
      Variable(:x)
    end
  end

  describe '#reduce' do
    describe 'given a local context' do
      it 'resolves to a value' do
        variable = Variable(:x)
        environment = { x: Number(5) }
        variable.reduce(environment).must_equal Number(5)
      end
    end
  end
end
