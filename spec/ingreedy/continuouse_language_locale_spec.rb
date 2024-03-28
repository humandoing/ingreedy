require 'ingreedy/continuous_language_locale'

RSpec.describe Ingreedy::ContinuousLanguageLocale do
  include Ingreedy::ContinuousLanguageLocale

  describe '#use_whitespace?' do
    context 'when the locale is a continuous language' do
      it 'returns false' do
        expect(use_whitespace?(:ja)).to be_falsey
        expect(use_whitespace?(:'zh-TW')).to be_falsey
      end
    end

    context 'when the locale is not a continuous language' do
      it 'returns true' do
        expect(use_whitespace?(:en)).to be_truthy
        expect(use_whitespace?(:fr)).to be_truthy
        expect(use_whitespace?(:'zh-CN')).to be_truthy
      end
    end
  end
end
