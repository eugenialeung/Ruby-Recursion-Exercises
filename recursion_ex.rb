# WARMUP

# Write a recursive method, range, that takes a start and an end and returns an array of all numbers
# in that range, exclusive. For example, range(1,5) should return [1 ,2, 3, 4]. If end < start, you can return an empty array.

def range(start_num, end_num)
    return [] if end_num =< start_num
    range(start_num, end_num - 1) <<  end_num - 1
end

# Write both a recursve and iterative version of sum of an array

def iterative_sum(array)
    sum = 0
    array.each do |ele|
        sum += ele
    end
    sum
end

def recursive_sum(arr)
    return arr.first if arr.length < 1
    arr.pop + recursive_sum(arr)
end


# EXPONENTIATION

# Write two versions of exponent that use two different recursions

# this is math, not Ruby methods.

# recursion 1
# exp(b, 0) = 1
# exp(b, n) = b * exp(b, n - 1)

def exp1(base, power)
    return 1 if power == 0
    base * exp1(base, power - 1)
end

exp1(5, 0)
exp1(3, 4)
exp1(10, 1)

# 10 * exp(10, 0)

# 3 * exp(3, 3)
# 3 * 3 * exp(3, 2)
# 3 * 3 * 3 * exp(3, 1)
# 3 * 3 * 3 * 3 * exp(3, 0)
# 3 * 3 * 3 * 3 * 1 


# recursion 2
# exp(b, 0) = 1
# exp(b, 1) = b
# exp(b, n) = exp(b, n / 2) ** 2             [for even n]
# exp(b, n) = b * (exp(b, (n - 1) / 2) ** 2) [for odd n]

def exp2(base, power)
    return 1 if power == 0
    half = exp2(base, power / 2)

    if power.even?
      half * half
    else
      # note that (power / 2) == ((power - 1) / 2) if power.odd?
      base * half * half
    end
end

exp2(5, 0)
exp2(3, 4)
exp2(10, 1)
exp2(5,3)

# DEEP DUP
    def deep_dup
        new_arr = []
        self.each do |ele|
            if ele.is_a?(Array) 
                new_arr << ele.deep_dup
            else
                new_arr << ele
            end
            new_arr
        end
    end

    # OR you can use a one-liner
    def dd_map
        map { |el| el.is_a?(Array) ? el.dd_map : el }
    end
end

[1, [2], [3, [4]]].deep_dup


# FIBONACCI
# Write a recursive and an iterative Fibonacci method. The method should take in an 
# integer n and return the first n Fibonacci numbers in an array

def fibonacci_iter(n)
    return [] if n == 0
    return [0] if n == 1
    fibs = [0, 1]
    while fibs.count < n
        fibs << fibs[-2] + fibs[-1]
    end
    fibs
end

def fibonacci_rec(n)
    if n <= 2
        [0, 1].take(n)
    else 
        fibs = fibs_rec(n - 1)
        fibs << fibs[-2] + fibs[-1]
    end
end


# BINARY SEARCH
# Compares the target value to the value of the middle element of the sorted array. 
# If the target value is equal to the middle element's value, then the position is returned and the search is finished.
# If the target value is less than the middle element's value, then the search continues on the lower half of the array;
# or if the target value is greater than the middle element's value, then the search continues on the upper half of the array. 
# This process continues, eliminating half of the elements, and comparing the target value to the value of the middle element of the remaining elements - until the target value is either found (and its associated element position is returned), or until the entire array has been searched (and "not found" is returned).
def bsearch(nums, target)
    # nil if not found; can't find anything in an empty array
    return nil if nums.empty?
  
    probe_index = nums.length / 2
    case target <=> nums[probe_index]
    when -1
      # search in left
      bsearch(nums.take(probe_index), target)
    when 0
      probe_index # found it!
    when 1
      # search in the right; don't forget that the right subarray starts
      # at `probe_index + 1`, so we need to offset by that amount.
      sub_answer = bsearch(nums.drop(probe_index + 1), target)
      sub_answer.nil? ? nil : (probe_index + 1) + sub_answer
    end
  
    # Note that the array size is always decreasing through each
    # recursive call, so we'll either find the item, or eventually end
    # up with an empty array.
  end

bsearch([1, 2, 3], 1) # => 0
bsearch([2, 3, 4, 5], 3) # => 1
bsearch([2, 4, 6, 8, 10], 6) # => 2
bsearch([1, 3, 4, 5, 9], 5) # => 3
bsearch([1, 2, 3, 4, 5, 6], 6) # => 5
bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
bsearch([1, 2, 3, 4, 5, 7], 6) # => nil


# MERGE SORT
# sorts an array
# The base cases are for arrays of length zero or one. Do not use a length-two array as a base case
# You'll want to write a merge helper method to merge the sorted halves


class Array
    def merge_sort
      return self if count < 2
  
      middle = count / 2
  
      left, right = self.take(middle), self.drop(middle)
      sorted_left, sorted_right = left.merge_sort, right.merge_sort
  
      merge(sorted_left, sorted_right)
    end
  
    def merge(left, right)
      merged_array = []
      until left.empty? || right.empty?
        merged_array << (left.first < right.first) ? left.shift : right.shift
      end
  
      merged_array + left + right
    end
end


# ARRAY SUBSETS
# Method subsets will return all subsets of an array
# Hint: For subsets([1, 2, 3]), there are two kinds of subsets:
# Those that do not contain 3 (all of these are subsets of [1, 2]).
# For every subset that does not contain 3, there is also a corresponding subset that is the same, except it also does contain 3.

class Array
    def subsets
      return [[]] if empty?
      subs = take(count - 1).subsets
      subs.concat(subs.map { |sub| sub + [last] })
    end
end  
subsets([]) # => [[]]
subsets([1]) # => [[], [1]]
subsets([1, 2]) # => [[], [1], [2], [1, 2]]
subsets([1, 2, 3])
# => [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]


# PERMUTATIONS
# Write a recursve method that calculates all the permutations of the given array.
# For an array of length n there are n! different permutations.
# So for an array with three elements we will have 3 * 2 * 1 = 6 different permutations
permutations([1, 2, 3]) # => [[1, 2, 3], [1, 3, 2],
                        #     [2, 1, 3], [2, 3, 1],
                        #     [3, 1, 2], [3, 2, 1]]

# You can use Ruby's built in Array#permutation method to geta better understanding
[1, 2, 3].permutation.to_a  # => [[1, 2, 3], [1, 3, 2],
                            #     [2, 1, 3], [2, 3, 1],
                            #     [3, 1, 2], [3, 2, 1]]

def permutations(array)
    return [array] if array.length <= 1
    
    
    # Similar to the subsets problem, we observe that to get the permutations
    # of [1, 2, 3] we can look at the permutations of [1, 2] which are
    # [1, 2] and [2, 1] and add the last element to every possible index getting
    # [3, 1, 2], [1, 3, 2], [1, 2, 3], [3, 2, 1], [2, 3, 1]
    
    # pop off the last element
    first = array.shift
    # make the recursive call
    perms = permutations(array)
    # we will need an array to store all our different permutations
    total_permutations = []
    
    
    # Now we iterate over the result of our recusive call say [[1, 2], [2, 1]]
    # and for each permutation add first into every index. This new subarray
    # gets added to total_permutations.
    perms.each do |perm|
        (0..perm.length).each do |i|
        total_permutations << perm[0...i] + [first] + perm[i..-1]
        end
    end
    total_permutations
end


# MAKE CHANGE
make_change(99, [25, 10, 5, 1]) 
3 * 25 # leaves me with 24
2 * 10 # leaves 4
0 * 5 # leaves 4
4 * 1 # leaves 0
def make_change_iter(amount, coins = [25, 10, 5, 1])
  change = []
  # relies on coins being in descending order. 
  coins.each do |coin|
    count = amount / coin
    count.times { change << coin }
    amount = amount - count * coin

  end
  change
end

p make_change_iter(99,[25, 10, 5, 1])

def make_change_recur(amount, coins = [25, 10, 5, 1])
  # Immediately tries to use as many of the biggest as possibles
  change = []
  first_coin = coins[0]
  count = amount / first_coin
  count.times { change << first_coin }
  amount = amount - count * first_coin

  if amount > 0
    change = change + make_change_recur(amount, coins.drop(1))
  end
  change


end

p make_change_recur(99, [25, 10, 5, 1])


def make_change_recur_ii(amount, coins)
  return [] if amount == 0
  # Instead: use only one of the biggest coin possible.
  best_change = nil

  coins.each do |coin|
    next if coin > amount

    change_for_rest = make_change_recur_ii(amount - coin, coins)
    change = [coin] + change_for_rest
    
    if best_change.nil? || change.count < best_change.count
      best_change = change
    end
    # p "Used 1 #{coin}"
    # p change
  end 

  best_change
end

p make_change_recur_ii(14, [10, 7, 1])

# Best of:
# [10] + make_change(4)
# [7] + make_change(7)
# [1] + make_change(13)