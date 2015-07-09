module BinaryTree
  class Node
    attr_reader :node
    attr_accessor :left, :right

    def initialize(node)
      @node = node
    end
  end
end