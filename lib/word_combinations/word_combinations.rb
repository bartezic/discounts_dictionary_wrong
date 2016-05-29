require_relative 'dictionary'
require_relative 'combinations/ordered'

def find_possible_combinations(dictionary_entries, word)
  dictionary = WordCombinations::Dictionary.for_entries(dictionary_entries)
  WordCombinations::Combinations::Ordered.new(dictionary).all_for(word)
end