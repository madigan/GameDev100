require 'gosu'

require './GameObject.rb'

class Gaul < GameObject
  attr_reader :boulders
  def initialize(image, x = 0, y = 0, speed = 50)
    super(image, x, y, speed)
    @boulders = Array.new
    @current_boulder = nil
    
    @cooldown_length = 0.5
    @cooldown = 0
  end
  
  def update( world, step )
    if world.button_down? Gosu::KbLeft  or world.button_down? Gosu::KbA and @x > 0 then
      @x -= step * @speed
    elsif world.button_down? Gosu::KbRight or world.button_down? Gosu::KbD and @x + @image.width < world.width then
      @x += step * @speed
    end
    
    if @current_boulder == nil then
      # Get the next available boulder
      @boulders.count.times do |i|
        if @boulders[i].state == :available then
          @current_boulder = @boulders[i]
          @current_boulder.state = :aiming
          break
        end
      end
    elsif world.button_down? Gosu::KbSpace and @cooldown <= 0 then
        @current_boulder.throw()
        @current_boulder = nil
        @cooldown = @cooldown_length
    end
    
    # Decrement the cooldown
    if @cooldown > 0 then
      @cooldown -= step
    end
  end
end
