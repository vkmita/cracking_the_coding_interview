def max_subarray(arr):
  current_sum = 0
  current_index = -1
  best_sum = 0
  best_start_index = -1
  best_end_index = -1

  for i in range(len(arr)):
    val = current_sum + arr[i]
    if val > 0:
      if current_sum == 0:
        current_index = i
      current_sum = val
    else:
      current_sum = 0

    if current_sum > best_sum:
      best_sum = current_sum
      best_start_index = current_index
      best_end_index = i
  return arr[best_start_index..best_end_index + 1]
