require 'gosu'

require './GameObject.rb'

class Boulder < GameObject
  attr_accessor :state
  def initialize(image, x = 0, y = 0, speed = 50, thrower)
    super(image, x, y, speed)
    @state = :available
    @thrower = thrower
  end
  
  def update( world, step )
    case @state
      when :available then
        # Do nothing
      when :aiming then
        # Align with Gaul (aimer)
        @x = @thrower.x
        @y = @thrower.y - @thrower.height
      when :flying then
        # Move up until off the screen
        if @y + @image.height < 0 then
          @state = :available
        else
          @y -= step * @speed
        end
      end
  end
  
  def throw
    if @state == :aiming then
      @state = :flying
    end
  end
  
  def draw( )
    if @state != :available then
      super
    end
  end
end
