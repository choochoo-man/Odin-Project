# Build a method #bubble_sort that takes an array and returns a sorted array.

def bubble_sort(unsorted_array)
  (unsorted_array.length * unsorted_array.length).times do

    unsorted_array.each_with_index do |number, index|
      left_number = index 
      right_number = left_number + 1

      until left_number + 1 == unsorted_array.length
        if unsorted_array[left_number] > ((unsorted_array[right_number]).to_i)
          unsorted_array[left_number], unsorted_array[right_number] = unsorted_array[right_number], unsorted_array[left_number]
        end
        left_number += 1
        right_number += 1
      end
        
    end
  end
  unsorted_array
  
end

pp bubble_sort([4,3,78,2,0,2])