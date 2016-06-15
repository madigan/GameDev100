require 'gosu'

class GameObject
    def initialize(image, x = 0, y = 0, speed = 0)
        @image = image
        @x = x
        @y = y
        @speed = speed
    end
    
    attr_reader :x, :y
    
    def draw
        @image.draw( @x, @y, 0 )
    end
    
    def update( step )
      
    end
    
    def reset
      
    end
    
    def width
        return @image.width
    end
    
    def height
        return @image.height
    end
end