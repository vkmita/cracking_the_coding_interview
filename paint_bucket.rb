class WFiller
  attr_reader :grid, :height, :width

  def initialize(grid, start_row, start_column)
    @grid = grid
    @height = grid.size
    @width = grid.first.size

    fill(start_row, start_column)
  end

  def fill(row, column)
    grid[row][column] = 'O'

    next_coordinates(row, column).each do |next_row, next_column|
      fill(next_row, next_column)
    end
  end

  def next_coordinates(row, column)
    _next_coordinates = []

    [-1, 0, 1].each do |row_add|
      [-1, 0, 1].each do |column_add|
        next if row_add == 0 && column_add == 0

        next_row_index = row + row_add
        next_column_index = column + column_add

        if valid_coordinate?(next_row_index, next_column_index)
          _next_coordinates << [next_row_index, next_column_index]
        end
      end
    end

    _next_coordinates
  end

  def valid_coordinate?(row, column)
    in_bounds?(row, height) && in_bounds?(column, width) &&
      grid[row][column] == 'W'
  end

  def in_bounds?(index, max)
    index >= 0 && index < max
  end

  def pretty_print
    grid.each do |row|
      puts row.join
    end
  end
end

input_string = <<-FOO
LLLLLLLLLLLLLLLLLLLL
LLLLLLLLLLLLLLWLLLLL
LLWWLLLLLLLLLLLLLLLL
LLWWLLLLLLLLLLLLLLLL
LLLLLLLLLLLLLLLLLLLL
LLLLLLLWWLLLLLLLLLLL
LLLLLLLLWWLLLLLLLLLL
LLLLLLLLLWWWLLLLLLLL
LLLLLLLLLLWWWWWWLLLL
LLLLLLLLLLWWWWWWLLLL
WWWWWLLLLLWWXWWWLLLW
LLLLWWLLLLWWWWWWLLLL
LLLLWWWLLLWWWWWWWWWW
LLLLLWWWWWWWWWWWLLLL
LLLLLLLLLLLLLLWWWWLL
LLLLLLLLLLLLLLWLLLLL
LLLLWLLLLLLLLLLLLWLL
LLLLLLLLLLLLLLLLLLWL
FOO

input = input_string.split("\n")
input.map! { |row| row.each_char.to_a }

wfiller = WFiller.new(input, 10, 12)
wfiller.pretty_print

"""
Input:

LLLLLLLLLLLLLLLLLLLL
LLLLLLLLLLLLLLWLLLLL
LLWWLLLLLLLLLLLLLLLL
LLWWLLLLLLLLLLLLLLLL
LLLLLLLLLLLLLLLLLLLL
LLLLLLLWWLLLLLLLLLLL
LLLLLLLLWWLLLLLLLLLL
LLLLLLLLLWWWLLLLLLLL
LLLLLLLLLLWWWWWWLLLL
LLLLLLLLLLWWWWWWLLLL
LLLLLLLLLLWWXWWWLLLL
LLLLWWLLLLWWWWWWLLLL
LLLLWWWLLLWWWWWWWWWW
LLLLLWWWWWWWWWWWLLLL
LLLLLLLLLLLLLLWWWWLL
LLLLLLLLLLLLLLWLLLLL
LLLLWLLLLLLLLLLLLWLL
LLLLLLLLLLLLLLLLLLWL

row = 10
col = 12

output

LLLLLLLLLLLLLLLLLLLL
LLLLLLLLLLLLLLWLLLLL
LLWWLLLLLLLLLLLLLLLL
LLWWLLLLLLLLLLLLLLLL
LLLLLLLLLLLLLLLLLLLL
LLLLLLLOOLLLLLLLLLLL
LLLLLLLLOOLLLLLLLLLL
LLLLLLLLLOOOLLLLLLLL
LLLLLLLLLLOOOOOOLLLL
LLLLLLLLLLOOOOOOLLLL
LLLLLLLLLLOOOOOOLLLL
LLLLOOLLLLOOOOOOLLLL
LLLLOOOLLLOOOOOOOOOO
LLLLLOOOOOOOOOOOLLLL
LLLLLLLLLLLLLLOOOOLL
LLLLLLLLLLLLLLOLLLLL
LLLLWLLLLLLLLLLLLWLL
LLLLLLLLLLLLLLLLLLWL
"""

