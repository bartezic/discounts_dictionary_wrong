module WordCombinations
  module Combinations
    class Ordered
      attr_reader :dictionary

      def initialize(dictionary)
        @dictionary = dictionary
      end

      def all_for(word)
        find_all_combinations(combinations = [], word, [])
        combinations.map {|entries| entries.join(' ')}
      end

      protected
      def find_all_combinations(combinations, word, collected)
        return collect_result(combinations, collected) if word.empty?
        dictionary.prefixes_for(word).each do |prefix|
          find_all_combinations(combinations, rest_of_word(word, prefix), collect_prefix(collected, prefix))
        end
      end

      def collect_prefix(collected, prefix)
        collected + [prefix]
      end

      def collect_result(combinations, collected)
        combinations.push(collected)
        combinations
      end

      def rest_of_word(word, prefix)
        word[prefix.size .. -1]
      end
    end
  end
end