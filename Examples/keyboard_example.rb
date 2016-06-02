require 'gosu'

class KeyboardExample < Gosu::Window
	def initialize
		super 640, 480
		self.caption = "Keyboard Example"
		@font = Gosu::Font.new(32, name: "Nimbus Mono L")
		self.text_input = Gosu::TextInput.new
		self.text_input.text = "Type something!"
		
		@text_y = 20
	end
	
	def button_up(key_id)
	    if key_id == Gosu::KbEscape then
	        close
	    end
	end
	
	def update
	    if button_down?(Gosu::KbDown) then
	        @text_y += 1
	    elsif button_down?(Gosu::KbUp) then
	        @text_y -= 1
	    end
	end

	def draw
	    @font.draw(self.text_input.text, 20, @text_y, 0)
	end
end

window = KeyboardExample.new
window.show
