#!/usr/bin/env ruby

# Given a list of signed ints and a target, find the combination of exactly three elements of nums that sums 
# most closely to target, in either a positive or negative direction.

nums = [-1,2,1,4]
target = 6

raise "No duplicate entries allowed, for now" unless nums.sort.uniq == nums.sort

# build a list of paired distances:
# pairs = {}
rev_pairs = {}
nums.each do |start_num|
  nums.each do |target_num|
    next if target_num == start_num
    sum = target_num + start_num
    # pairs[start_num][target_num] = sum
    rev_pairs[sum] = [start_num, target_num]
  end
end

scores = {}

def find_best_match(nums, rev_pairs, target)
  best_match = {}
  nums.each_with_index do |num, i|
    rev_pairs.keys.each do |pair_sum|
      sum = num + pair_sum
      next if rev_pairs[pair_sum].include?(num)
      tuple = rev_pairs[pair_sum].dup << num
      score = (target - sum).abs
      match = {tuple: tuple, score: score}
      return match if sum == target # Perfect match, stop looking.
      best_match = match if best_match.empty? or score < best_match[:score] 
    end
  end
  return best_match
end

best_match = find_best_match(nums, rev_pairs, target)

puts "The three closest numbers were: #{best_match[:tuple].join(', ')}, which was #{best_match[:score]} "\
     "away from #{target}."

