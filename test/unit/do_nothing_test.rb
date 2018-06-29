describe DoNothing do
  describe 'module functionality' do
    it "doesn't break" do
      DoNothing()
    end
  end

  describe '#reducible' do
    it 'is not reducible' do
      refute DoNothing().reducible?
    end
  end
end
