require 'gosu'

require './Gaul.rb'
require './Boulder.rb'

class RagingRomansGame < Gosu::Window
  WINDOW_WIDTH = 640
  WINDOW_HEIGHT = 480
  GAUL_SPEED = 100
  
  BOULDER_COUNT = 3
  
  def initialize
    super WINDOW_WIDTH, WINDOW_HEIGHT
    self.caption = "Raging Romans"
    
    # Load Resources
    gaul_image = Gosu::Image.new("assets/Gaul.png")
    boulder_image = Gosu::Image.new("assets/Boulder.png")

    # Create Game Objects
    gaul = Gaul.new(
        gaul_image, WINDOW_WIDTH / 2 - gaul_image.width / 2, 
        WINDOW_HEIGHT - gaul_image.height, 
        GAUL_SPEED)
        
    @game_objects = Array.new 
    @game_objects << gaul
    BOULDER_COUNT.times do |i|
      boulder = Boulder.new( boulder_image, 0, 0, 200, gaul )
      @game_objects << boulder
      gaul.boulders << boulder
    end
    
  end
  
  def update
    step = self.update_interval / 1000
    @game_objects.each {|obj| obj.update( self, step )}
  end

  def draw
    @game_objects.each {|obj| obj.draw( )}
  end
  
  def reset
    @game_objects.each {|obj| obj.reset( self )}
  end
end

# Run our game
window = RagingRomansGame.new
window.show