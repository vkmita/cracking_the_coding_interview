module LinkedList
  class Node
    attr_reader :node
    attr_accessor :next

    def initialize(node)
      @node = node
    end
  end
end
