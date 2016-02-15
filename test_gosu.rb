require 'gosu'

class GameWindow < Gosu::Window
	def initialize
		super 640, 480
		self.caption = "My First Game"
		@font = Gosu::Font.new(32, name: "Nimbus Mono L")
	end

	def draw
	    @font.draw("Otter.Tech Rocks my Socks!", 20, 20, 0)
	end
end

window = GameWindow.new
window.show
