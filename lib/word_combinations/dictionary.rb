require_relative 'dictionaries/prefixes_locator'

module WordCombinations
  class Dictionary
    WORD_END = :end_of_word

    attr_reader :tree

    def initialize
      @tree = {}
    end

    def add_dictionary_entries(dictionary)
      dictionary.each { |entry| add_to_tree(entry) }
      self
    end

    def prefixes_for(word)
      Dictionaries::PrefixesLocator.new(tree).locate_for(word)
    end

    def self.for_entries(entries)
      self.new.add_dictionary_entries(entries)
    end

    protected
    def add_to_tree(entry)
      current_node = tree
      entry.each_char do |letter|
        current_node[letter] ||= {}
        current_node = current_node[letter]
      end
      current_node[WORD_END] = true
    end
  end
end