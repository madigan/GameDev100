require 'gosu'

class ImageExample < Gosu::Window
    def initialize
        super 640, 480
        self.caption = "Image Example"
        
        @ball = Gosu::Image.new("assets/Ball.png")
        
    end
    
    def draw
        @ball.draw( 32, 32, 0 )
    end
end

window = ImageExample.new
window.show
