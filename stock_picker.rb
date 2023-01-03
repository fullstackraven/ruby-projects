#T.O.P. Project
#Implement a method #stock_picker that takes in an array 
#of stock prices, one for each hypothetical day. 
#It should return a pair of days representing the best day 
#to buy and the best day to sell. Days start at 0.

stock_prices = [17,3,6,9,15,8,6,1,10]
#test1 = [15,4,9,8,12,6,1,3,18]
#test2 = [2,44,94,52,132,26,61,43,138]
#test3 = [150,40,90,80,120,60,100,300,180]

def stock_picker(array)
  output = [0,0]
  profit = 0

  buy_day = array[0]
  buy_index = 0

  sell_day = 0
  sell_index = 0
  #Handles method local varibles

  array.each.with_index() do |price, index|
    if buy_day > price
      buy_day = price
      buy_index = index
      next
    end
    #Handles finding index for buy day [Day 1 or stock price of 3]

    if profit < price - buy_day
      sell_day = price
      profit = sell_day - buy_day
      sell_index = index
      output = [buy_index, sell_index]
    end
    #Handles establishing profit and finding index for sell day [Day 4 or stock price 15]
  end
  output
end

puts "Days to buy and sell are: " + stock_picker(stock_prices).to_s
# => [1, 4]
#For a profit of $15 - $3 == $12