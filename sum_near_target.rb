#!/usr/bin/env ruby

# Given a list of signed ints and a target, find the combination of exactly three elements of nums that sums 
# most closely to target, in either a positive or negative direction.

nums = [-1,2,1,4]
target = 6

puts "Given the list #{nums.join(', ')}, we want the first combination of three members that sum nearest #{target}."

# Build a lookup of sums of pairs:
rev_pairs = {}
nums.each_with_index do |start_num, o|
  i = o+1
  while i < nums.size
    target_num = nums[i]
    sum = target_num + start_num
    unless rev_pairs.key?(sum)
      rev_pairs[sum] = [o, i]
    end
    i += 1
  end
end

def find_nearest_key(keys, target, inc)
  return target if keys.include?(target) # exact match!
  keys_plus_target = (keys.dup << target).sort
  i = keys_plus_target.index(target)
  return keys.index(keys_plus_target[1]) if i.zero?
  return keys.index(keys_plus_target[-2]) if i == keys.size
  delta_up = keys_plus_target[i+1] - target
  delta_down = target - keys_plus_target[i-1]
  return keys.index(keys_plus_target[i+1]) if delta_up < delta_down
  return keys.index(keys_plus_target[i-2])
end


def find_best_match(nums, rev_pairs, target)
  best_match = {}
  nums.each_with_index do |num, i|
    delta = target - num
    nearest_key = find_nearest_key(rev_pairs.keys, delta, 1) 
    sum = num + nearest_key
    next if rev_pairs[nearest_key].include?(i)
    tuple = []
    rev_pairs[nearest_key].each { |j| tuple << nums[j] }
    tuple << num
    score = (target - sum).abs
    match = { tuple: tuple, score: score }
    best_match = match if best_match.empty? or score < best_match[:score] 
  end
  return best_match
end

best_match = find_best_match(nums, rev_pairs, target)

puts "The three closest numbers were: #{best_match[:tuple].join(', ')}, which was #{best_match[:score]} "\
     "away from #{target}."

