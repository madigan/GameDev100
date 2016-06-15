require 'gosu'

require './GameObject.rb'

class Gaul < GameObject
    def initialize(image, x = 0, y = 0, speed = 50)
      super(image, x, y, speed)
    end
end
