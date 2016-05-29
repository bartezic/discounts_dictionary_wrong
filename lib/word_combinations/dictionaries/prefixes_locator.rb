module WordCombinations
  module Dictionaries
    class PrefixesLocator
      attr_reader :tree

      def initialize(tree)
        @tree = tree
      end

      def locate_for(task_word)
        node, prefixes = tree, []
        task_word.each_char.with_index do |char, index|
          break unless (node = node[char])
          prefixes << collect_word(node, task_word, index)
        end
        prefixes.compact
      end


      protected
      def word_end_node?(current_node)
        current_node[WordCombinations::Dictionary::WORD_END]
      end

      def collect_word(node, word, index)
        word_end_node?(node) ? word[0, index + 1] : nil
      end
    end
  end
end