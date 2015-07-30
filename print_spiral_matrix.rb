require 'byebug'

# Matrix is a 2d array

class DiagonalMatrixPrinter
  attr_accessor :height, :width, :current_x, :current_y, :current_direction_x, :current_direction_y, :result
  attr_reader :matrix

  def initialize(matrix)
    @matrix = matrix

    self.width = matrix.first.length - 1
    self.height = matrix.length - 2

    self.current_direction_x = 'right'
    self.current_direction_y = 'down'

    self.current_x = 0
    self.current_y = 0

    self.result = []
  end

  def print
    [:right, :down, :left, :up].cycle do |direction|
      case direction
      when :right
        right_left((current_x..(current_x + width)).to_a, 1)
      when :down
        down_up((current_y..(current_y + height)).to_a, -1)
      when :left
        right_left(((current_x - width)..current_x).to_a.reverse, -1)
      when :up
        down_up(((current_y - height)..current_y).to_a.reverse, 1)
      end

      if width < 0 && height < 0
        return puts "#{result}"
      end
    end
  end

  def right_left(array_range, y_change)
    array_range.each do |temp_x|
      puts "#{temp_x} #{current_y} : #{matrix[current_y][temp_x]}"
      self.current_x = temp_x
      self.result <<  matrix[current_y][temp_x]
    end

    self.width -= 1
    self.current_y = current_y + y_change
  end

  def down_up(array_range, x_change)
    array_range.each do |temp_y|
      puts "#{current_x} #{temp_y} : #{matrix[temp_y][current_x]}"
      self.current_y = temp_y
      result <<  matrix[temp_y][current_x]
    end

    self.height -= 1
    self.current_x = current_x + x_change
  end
end




matrix = [
  [1, 2, 3],
  [8, 9, 4],
  [7, 6, 5]
]

DiagonalMatrixPrinter.new(matrix).print

matrix = [
  [1,  2, 3, 4],
  [12, 13, 14, 5],
  [11, 16, 15, 6],
  [10, 9, 8, 7]
]

DiagonalMatrixPrinter.new(matrix).print
