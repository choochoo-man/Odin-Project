def merge_sort(array, array_length = 0)
  if array.size > array_length
    array_length = array.size
  end
  if array.size < 2
    array
  else
    left = merge_sort(array.take(array.size / 2))
    right = merge_sort(array.drop(array.size / 2))
    merge(left, right, array_length)
  end
end

def merge(left, right, array_length, array = [])
  until array.length == array_length do
    if left.empty?
      array << right.shift
    elsif right.empty?
      array << left.shift
    else
      if left.first <= right.first
        array << left.shift
      else
        array << right.shift
      end
    end
  end
  array
end

array = []
20.times do
  array << rand(20)
end
pp array

pp merge_sort(array)

if array.sort == merge_sort(array)
  puts "Both arrays are the same"
else
  puts "You've changed the array"
end