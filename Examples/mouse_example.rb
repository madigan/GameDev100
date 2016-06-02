require 'gosu'

class MouseExample < Gosu::Window
	def initialize
		super 640, 480
		self.caption = "Mouse Example"
		@font = Gosu::Font.new(32, name: "Nimbus Mono L")
	end

	def draw
	    msg = sprintf "The mouse is at (%.0f,%.0f).", self.mouse_x, self.mouse_y
        @font.draw(msg, 20, 20, 0)
	end
	
	def needs_cursor?
	    true
	end
end

window = MouseExample.new
window.show
