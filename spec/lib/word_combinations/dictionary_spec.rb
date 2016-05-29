require 'spec_helper'
require 'word_combinations/dictionary'

describe WordCombinations::Dictionary do
  before do
    @dictionary = WordCombinations::Dictionary.new
    @dictionary.add_dictionary_entries(%w(aa aab abc bce a))
  end

  describe 'words prefixes' do
    def prefixes(word)
      @dictionary.prefixes_for(word).sort
    end

    it 'should return empty prefixes' do
      expect(prefixes('cde')).to eq(%w())
    end

    it 'should not return reversed prefix' do
      expect(prefixes('cba')).to eq(%w())
    end

    it 'should return single prefix' do
      expect(prefixes('bcef')).to eq(%w(bce))
    end

    it 'should return word as prefix' do
      expect(prefixes('bce')).to eq(%w(bce))
    end

    it 'should return all prefixex' do
      expect(prefixes('aabc')).to eq(%w(a aa aab))
    end
  end
end