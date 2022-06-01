# frozen_string_literal: true

# creating a Node class to capture the chess squares a knight piece visits as it makes its way to the destination square
class Node
  attr_accessor :coord, :dist, :pred

  def initialize(coordinate, distance, predecessor)
    @coord = coordinate
    @dist = distance
    @pred = predecessor
  end
end

def knight_moves(location, destination)
  # turns location coordinate into a node for start position
  start_location = Node.new(location, 0, nil)

  # assign destination's node to current_node, which will then be traversed to see
  # what the shortest path looks like to get knight from start location to destination
  current_node = knight_shortest_path(start_location, destination)

  # as the destination node and its pointers are traversed, node coordinates get pushed into moves_list
  moves_list = []

  puts "You made it in #{current_node.dist} moves! Here's your path:"

  until current_node.nil?
    moves_list << current_node.coord
    current_node = current_node.pred
  end

  # reverse moves_list to print moves from start_location to destination
  moves_list = moves_list.reverse
  moves_list.each { |move| p move }
end

# performs breadth-first search to identify the shortest path to destination
def knight_shortest_path(start_position, finish_position)
  # this is the behavior on how a knight piece can move per turn on the chess board
  knight_moves = [[1, 2], [2, 1], [2, -1], [1, -2], [-1, -2], [-2, -1], [-2, 1], [-1, 2]]
  queue = [start_position]
  # this array ensures that we don't traverse though any coordinates that have been traversed once before
  visited = []

  until queue.empty?
    current_position = queue.pop

    # when you finally locate the destination coordinate, return its node
    return current_position if current_position.coord == finish_position

    # identifies all the valid moves a knight piece came make next from its current position
    knight_moves.each do |move|
      next_position = [current_position.coord[0] + move[0], current_position.coord[1] + move[1]]

      # if the next position is valid (within chess board) and has not already been traversed
      # before, add its node to the queue and add its coordinate to the visited array
      if within_range(next_position) && !visited.include?(next_position)
        visited << next_position
        queue.unshift(Node.new(next_position, current_position.dist + 1, current_position))
      end
    end
  end
end

# this is a test to ensure only valid knight moves are being tracked (within the 8 x 8 chess board)
# x and y in coordinate (x, y) cannot be less than 0 and cannot be more than 7
def within_range(square_location)
  if square_location[0].between?(0, 7) && square_location[1].between?(0, 7)
    true
  else
    false
  end
end

knight_moves([3, 3], [4, 3])
