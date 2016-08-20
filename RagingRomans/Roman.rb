require 'gosu'

require './GameObject.rb'

class Roman < GameObject
  def initialize(image, x = 0, y = 0)
    @image = image
    @x = x
    @y = y
  end
end