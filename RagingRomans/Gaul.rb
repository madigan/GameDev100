require 'gosu'

require './GameObject.rb'

class Gaul < GameObject
    def initialize(image, x = 0, y = 0, speed = 50)
      super(image, x, y, speed)
    end
    
    def update( world, step )
      if world.button_down? Gosu::KbLeft  or world.button_down? Gosu::KbA and @x > 0 then
        @x -= step * @speed
      elsif world.button_down? Gosu::KbRight or world.button_down? Gosu::KbD and @x + @image.width < world.width then
        @x += step * @speed
      end
    end
end
