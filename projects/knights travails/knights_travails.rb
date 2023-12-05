require 'rgl/adjacency'
require 'rgl/dijkstra'
require 'rgl/traversal'
require 'rgl/path'
include RGL

board = RGL::AdjacencyGraph.new
edge_weights = {}

def make_edge(x, y, x_result, y_result, board, edge_weights)
  unless x_result > 8 || y_result > 8 || x_result < 1 || y_result < 1
    board.add_edge "[#{x},#{y}]", "[#{x_result},#{y_result}]"
    key = "[#{x},#{y}]", "[#{x_result},#{y_result}]"
    edge_weights[key] = 1
  end
end

def knight_data(x, y, board, edge_weights)
  x_result = x
  y_result = y

  x_result -= 1
  y_result += 2

  make_edge(x, y, x_result, y_result, board, edge_weights)

  x_result += 2

  make_edge(x, y, x_result, y_result, board, edge_weights)

  x_result += 1
  y_result -= 1

  make_edge(x, y, x_result, y_result, board, edge_weights)

  y_result -= 2

  make_edge(x, y, x_result, y_result, board, edge_weights)

  x_result -= 1
  y_result -= 1

  make_edge(x, y, x_result, y_result, board, edge_weights)

  x_result -= 2

  make_edge(x, y, x_result, y_result, board, edge_weights)

  x_result -= 1
  y_result += 1

  make_edge(x, y, x_result, y_result, board, edge_weights)

  y_result += 2

  make_edge(x, y, x_result, y_result, board, edge_weights)
end

(1..8).each do |x|
  (1..8).each do |y|
    knight_data(x, y, board, edge_weights)
  end
end

puts board.dijkstra_shortest_path(edge_weights, "[4,4]", "[1,1]")