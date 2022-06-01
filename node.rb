# creating a Node class to capture the chess squares a knight 
# piece visits as it makes its way to the destination square
class Node
  attr_accessor :coord, :dist, :pred

  def initialize(coordinate, distance, predecessor)
    @coord = coordinate
    @dist = distance
    @pred = predecessor
  end
end
