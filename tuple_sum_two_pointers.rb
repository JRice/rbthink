#!/usr/bin/env ruby

# Trying again, but with a "two-pointer" solution...

def three_sum_closest(in_nums, target)
  nums = in_nums.dup.sort

  # Gotta start somewhere:
  best_indexes = (0...2)
  best_sum = nums[0..2].sum

  (0...nums.size - 2).each do |i|
    # Skip this num if we already calculated this number (duplicates):
    next if i > 0 && nums[i] == nums[i - 1]

    left = i + 1
    right = nums.size - 1

    while left < right
      current_sum = nums[i] + nums[left] + nums[right]
      
      return { nums: [nums[i], nums[left], nums[right]], sum: current_sum } if current_sum == target

      # Update best_sum if the current_sum is closer to the target
      if (current_sum - target).abs < (best_sum - target).abs
        best_indexes = [i, left, right]
        best_sum = current_sum
      end

      if current_sum < target
        left += 1
      else
        right -= 1
      end
    end
  end

  return { nums: nums.values_at(*best_indexes), sum: best_sum }
end

# Execution
nums = [-1, 2, 1, 4, 5, 9, 2, 12]
target = 13
result = three_sum_closest(nums, target)

puts "The closest sum is #{result[:nums].join('+')} = #{result[:sum]}, which is #{(target - result[:sum]).abs} away from #{target}."
