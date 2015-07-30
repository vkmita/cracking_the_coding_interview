def quick_sort(array)
  return array if array.length == 1

  pivot = array.shift
  left_array = []
  right_array = []

  array.each do |number|
    if number < pivot
      left_array.push(number)
    else
      right_array.push(number)
    end
  end

  left_array = quick_sort(left_array) if left_array.any?
  right_array = quick_sort(right_array) if right_array.any?

  left_array + [pivot] + right_array
end

array = [8, 6, 1, 5, 8, 2, 9, 3, 0, 1]

puts quick_sort(array)

