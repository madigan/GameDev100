require 'gosu'

require './Gaul.rb'

class RagingRomansGame < Gosu::Window
  WINDOW_WIDTH = 640
  WINDOW_HEIGHT = 480
  GAUL_SPEED = 100
  
  def initialize
    super WINDOW_WIDTH, WINDOW_HEIGHT
    self.caption = "Raging Romans"
    
    # Load Resources
    gaul_image = Gosu::Image.new("assets/Gaul.png")

    # Create Game Objects
    @game_objects = Hash.new 
    @game_objects[:gaul] = Gaul.new(
        gaul_image, WINDOW_WIDTH / 2 - gaul_image.width / 2, 
        WINDOW_HEIGHT - gaul_image.height, 
        GAUL_SPEED)
  end
  
  def update
    step = self.update_interval / 1000
    @game_objects.each_value {|obj| obj.update( step )}
  end

  def draw
    @game_objects.each_value {|obj| obj.draw( )}
  end
  
  def reset
    @game_objects.each_value {|obj| obj.reset( )}
  end
end

# Run our game
window = RagingRomansGame.new
window.show