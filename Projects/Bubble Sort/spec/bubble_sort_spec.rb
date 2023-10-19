require 'spec-helper'
require relative '../bubble_sort.rb'

Rspec describe "Bubble Sort"
  describe "Bubble Sort" do
    it "Returns the input array after it has been sorted"
    expect (bubble_sort([[4,3,78,2,0,2]])).to eq ([0,2,2,3,4,78])
end