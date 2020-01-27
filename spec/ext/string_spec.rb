describe String do

  describe '#is_blank?' do
    context 'when string contains only whitespaces' do
      it 'returns true' do
        expect("".is_blank?).to be(true)
        expect("  ".is_blank?).to be(true)
      end
    end

    context 'when string contains only whitespaces' do
      it 'returns false' do
        expect("I am not blank".is_blank?).to be(false)
      end
    end
  end

end