# frozen_string_literal: true

describe String do
  describe '#is_blank?' do
    context 'when string contains only whitespaces' do
      it 'returns true' do
        expect(''.blank?).to be(true)
        expect('  '.blank?).to be(true)
      end
    end

    context 'when string contains only whitespaces' do
      it 'returns false' do
        expect('I am not blank'.blank?).to be(false)
      end
    end
  end
end
