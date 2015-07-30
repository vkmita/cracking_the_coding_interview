require 'byebug'

# Matrix is a 2d array

class DiagonalMatrixPrinter
  attr_accessor :height, :width, :current_x, :current_y, :current_direction_x, :current_direction_y, :result
  attr_reader :matrix

  def initialize(matrix)
    @matrix = matrix

    self.width = matrix.first.length - 1
    self.height = matrix.length - 2

    self.current_x = 0
    self.current_y = 0

    self.result = []
  end

  def print
    [:right, :down, :left, :up].cycle do |direction|
      case direction
      when :right
        print_line((current_x.upto(current_x + width)), y: 1)
      when :down
        print_line((current_y.upto(current_y + height)), x: -1)
      when :left
        print_line(current_x.downto(current_x - width), y: -1)
      when :up
        print_line(current_y.downto(current_y - height), x: 1)
      end

      if done?
        return puts "#{result}"
      end
    end
  end

  def print_line(range, changes)
    range.each do |current|
      puts "#{current_x} #{current_y} : #{matrix[current_y][current_x]}"
      self.current_y = current if changes[:x]
      self.current_x = current if changes[:y]
      result <<  matrix[current_y][current_x]
    end

    self.height -= 1 if changes[:x]
    self.width -= 1 if changes[:y]
    self.current_y = current_y + changes[:y] if changes[:y]
    self.current_x = current_x + changes[:x] if changes[:x]
  end

  def done?
    width < 0 || height < -1
  end
end

matrix = [
  [1, 2, 3],
  [8, 9, 4],
  [7, 6, 5]
]

DiagonalMatrixPrinter.new(matrix).print

matrix = [
  [1,   2,  3, 4],
  [12, 13, 14, 5],
  [11, 16, 15, 6],
  [10,  9,  8, 7]
]

DiagonalMatrixPrinter.new(matrix).print

matrix = [
  [1,   2,  3, 4, 5, 6],
  [12, 11, 10, 9, 8, 7]
]

DiagonalMatrixPrinter.new(matrix).print

matrix = [
  [1, 2],
  [3, 3],
  [7, 4],
  [6, 5]
]

DiagonalMatrixPrinter.new(matrix).print