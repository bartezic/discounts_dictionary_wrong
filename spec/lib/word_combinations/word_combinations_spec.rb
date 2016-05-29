require 'spec_helper'
require 'word_combinations/word_combinations'

describe 'Word Combinations' do
  before do
    @dictionary = %w(a b c ab abc abcd).shuffle
  end

  def sorted_combinations(word)
    find_possible_combinations(@dictionary, word).sort
  end

  it 'should find same word if in dictionary' do
    expect(sorted_combinations('abcd')).to eq(['abcd'])
  end

  it 'should find single combination' do
    expect(sorted_combinations('abcda')).to eq(['abcd a'])
  end

  it 'should find duplicated dictionary entries' do
    expect(sorted_combinations('aac')).to eq(['a a c'])
  end

  it 'should not find reversed entries' do
    expect(sorted_combinations('dcba')).to eq([])
  end

  it 'should find all combinations for correct word' do
    expect(sorted_combinations('aabc')).to eq(['a a b c', 'a ab c', 'a abc'])
  end

  it 'should not find combinations for uniq word' do
    expect(sorted_combinations('aabcx')).to eq([])
  end

end