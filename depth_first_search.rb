require 'set'

class DepthFirstSearch
  attr_reader :grid
  attr_accessor :expanded, :explored, :winning_path

  def initialize(pacman_r, pacman_c, grid)
    self.explored = Set.new
    self.expanded = [[pacman_r, pacman_c]]

    @grid = grid
    depth_first_seach(pacman_r, pacman_c, [[pacman_r, pacman_c]])
  end

  def depth_first_seach(pacman_r, pacman_c, current_stack)
    return if winning_path

    local_explored = []

    next_explorations(pacman_r, pacman_c).each do |exploaration|
      if should_explore?(exploaration)
        self.explored << exploaration
        local_explored << exploaration
      end
    end

    local_explored.each do |next_pacman_r, next_pacman_c|
      self.explored.delete([next_pacman_r, next_pacman_c])
      expand(next_pacman_r, next_pacman_c, current_stack.dup)

      return if winning_path
    end
  end

  def expand(pacman_r, pacman_c, current_stack)
    case grid[pacman_r][pacman_c]
    when '-'
      current_stack << [pacman_r, pacman_c]
      self.expanded << [pacman_r, pacman_c]

      depth_first_seach(pacman_r, pacman_c, current_stack)
    when '.'
      current_stack << [pacman_r, pacman_c]
      self.expanded << [pacman_r, pacman_c]

      self.winning_path = current_stack
    end
  end

  def next_explorations(pacman_r, pacman_c)
    [[pacman_r + 1, pacman_c], [pacman_r, pacman_c + 1], [pacman_r, pacman_c - 1], [pacman_r - 1, pacman_c]]
  end

  def should_explore?(exploaration)
    !explored.member?(exploaration) && !expanded.index(exploaration)
  end
end

pacman_r, pacman_c = gets.strip.split.map(&:to_i)
food_r, food_c = gets.strip.split.map(&:to_i)
r,c = gets.strip.split.map(&:to_i)

grid = Array.new(r)

(0...r).each do |i|
  grid[i] = gets.each_char.to_a
end


dfs = DepthFirstSearch.new(pacman_r, pacman_c, grid)

puts dfs.expanded.size
puts dfs.expanded.map { |pacman_r, pacman_c| "#{pacman_r} #{pacman_c}" }

puts dfs.winning_path.size - 1
puts dfs.winning_path.map { |pacman_r, pacman_c| "#{pacman_r} #{pacman_c}" }