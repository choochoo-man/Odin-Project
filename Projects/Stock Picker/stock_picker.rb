# Implement a method #stock_picker that takes in an array of stock prices, one for each hypothetical day.
# It should return a pair of days representing the best day to buy and the best day to sell. Days start at 0.

def stock_picker_v1(stock_prices)
  buy_sell = []
  buy_sell << (stock_prices.index(stock_prices.min))
  buy_sell << (stock_prices.index(stock_prices.max))
  buy_sell
end

# pp stock_picker_v1([17,3,6,9,15,8,6,1,10]) 

def stock_picker_v2(stock_prices)
  best_days = [0, 0]

  stock_prices.each_with_index do |price, i|
    count = i + 1

    until (count) >= stock_prices.length  # stops when the count variable (used as an index) reaches the end of the stock_prices array
      if (stock_prices[count] - price) > (best_days[1]) - (best_days[0])  #if (profit of current evalutaion) is greater than (profit stored in best_days)
        best_days[0] = price                                              # set the first value of the best_days array to the price (buy price)
        best_days[1] = stock_prices[count]                                # set the second value of the best_days array to the the number in the stock_prices array at the index of count (sell_price)
      end

      count += 1    # iterates a long the stock_prices array
    end
  end

  best_days   # array with 2 values, best_days[0] is buy price, best_days[1] is sell price
end

    best_days = stock_picker_v2([17,3,6,9,15,8,6,1,10,6,2,4,7,20,1,35])
    profit = best_days[1] - best_days[0]
    puts "You are buying at a price of #{best_days[0]} and you are selling at a price of #{best_days[1]}, for a profit of #{profit}"
