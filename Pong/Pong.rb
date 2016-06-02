require 'gosu'

WINDOW_WIDTH = 640
WINDOW_HEIGHT = 480

FONT_SIZE = 32
FONT_NAME = "Nimbus Mono L"
SCORE_PADDING = 10

class PongGame < Gosu::Window
    attr_reader :player_paddle, :computer_paddle
	def initialize
		super WINDOW_WIDTH, WINDOW_HEIGHT
		self.caption = "Pong"
		
        @music = Gosu::Song.new("assets/music.ogg")
        @font = Gosu::Font.new(FONT_SIZE, name: FONT_NAME)
        bounce_sfx = Gosu::Sample.new("assets/bounce.wav")
        ball_img = Gosu::Image.new("assets/Ball.png")
        paddle_img = Gosu::Image.new("assets/Paddle.png")
        
		@ball = Ball.new(ball_img, self, bounce_sfx, self.width / 2, self.height / 2, 200)
		
		@player_paddle = PlayerPaddle.new(
		    paddle_img, self, 20, self.height / 2, 100)
		@player_score = 0
		
		@computer_paddle = ComputerPaddle.new(
		    paddle_img, self, @ball, self.width - 84, self.height / 2, 100)
		@computer_score = 0
	end
	
	def button_up(key_id)
	    if key_id == Gosu::KbEscape then
	        close
	    elsif key_id == Gosu::KbM then
	        if @music.playing? then
                @music.stop
            elsif 
                @music.play(true)
            end
	    end
	end
	
	def notify( event )
	    if event == :left_score then
	        @computer_score += 1
	        reset
	    elsif event == :right_score then
	        @player_score += 1
	        reset
	    end
	end
	
	def update
	    step = self.update_interval / 1000
	    @ball.update( step )
	    @player_paddle.update( step )
	    @computer_paddle.update( step )
	end

	def draw
	    @font.draw(@player_score, SCORE_PADDING, SCORE_PADDING, 0)
	    @font.draw(@computer_score, WINDOW_WIDTH-2*SCORE_PADDING, SCORE_PADDING, 0)
	    
	    @ball.draw
	    @player_paddle.draw
	    @computer_paddle.draw
	end
	
	def reset
	    @ball.reset
	    @player_paddle.reset
	    @computer_paddle.reset
	end
end

########################
### Our Game Classes ###
########################
class GameObject
    def initialize(image, world, x = 0, y = 0, speed = 10)
        @image = image
        @world = world
        @x = x
        @y = y
        @speed = speed
    end
    
    attr_reader :x, :y
    
    def draw
        @image.draw( @x, @y, 0 )
    end
    
    def reset
        @y = @world.height / 2 - width / 2
    end
    
    def width
        return @image.width
    end
    
    def height
        return @image.height
    end
end

class Ball < GameObject
    def initialize(image, world, sfx, x = 0, y = 0, speed = 0, angle = 0)
        super(image, world, x, y, speed)
        @bounce_sfx = sfx
        @v_x = Math.cos(angle)
        @v_y = Math.sin(angle)
    end
    
    def update(tick)
        @x += tick * @speed * @v_x
        @y += tick * @speed * @v_y
        
        # Handle world collisions
        if @x + @image.width < 0 then
            @world.notify( :left_score )
        elsif @x > @world.width then
            @world.notify( :right_score )
        end
        if @y < 0 or @y > @world.height - @image.height then
            @v_y *= -1
            @bounce_sfx.play
        end
        
        # Handle paddle collisions. These are fairly simple (only handles x-axis)
        if  overlaps?( @world.player_paddle ) or
            overlaps?( @world.computer_paddle ) then
            # Simple bounce which will serve our purposes.
            @v_x *= -1
            @bounce_sfx.play
        end
    end
    
    def overlaps?(go)
        # Basic "Overlapping Rectangle" Check
        if  @x + width > go.x and
            @x < go.x + go.width and
            @y + height > go.y and
            @y < go.y + go.height then
            # Now we *should* check for "corner cases"... heh...
            return true
        else
            return false
        end
    end
	
    def reset
        super
        @x = @world.width / 2 - width / 2
        angle = 45 + rand(15)
        @v_x = Math.cos(angle)
        @v_y = Math.sin(angle)
    end
end

class ComputerPaddle < GameObject
    def initialize(image, world, ball, x = 0, y = 0, speed = 50, buffer = 32)
        super(image, world, x, y)
        @speed = speed
        @buffer = buffer
        @ball = ball
    end
    
    def update( step )
        # If the center of the ball is below the center of the paddle plus
        # the buffer, the paddle should move down.
	    if @ball.y + @ball.height / 2 > @y + height / 2 + @buffer then
	        @y += @speed * step
	    # If the center of the ball is above the center of the paddle minus
	    # the buffer, the paddle should move up.
	    elsif @ball.y + @ball.height / 2 < @y + height / 2 - @buffer then
	        @y -= @speed * step
	    end
    end
end

class PlayerPaddle < GameObject
    def initialize(image, world, x = 0, y = 0, speed = 50)
        super(image, world, x, y)
        @speed = speed
    end
    
    def update( step ) 
	    if @world.button_down?(Gosu::KbDown) or @world.button_down?(Gosu::KbS) then
	        @y += @speed * step
	    elsif @world.button_down?(Gosu::KbUp) or @world.button_down?(Gosu::KbW) then
	        @y -= @speed * step
	    end
    end
end


########################
window = PongGame.new
window.show
