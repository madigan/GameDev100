require 'gosu'

require './GameObject.rb'
require './Roman.rb'

class Formation < GameObject
  def initialize( columns, rows )
    @romans = Array.new
    columns.times do |column|
      @romans[col] = Array.new
      rows.times do |row|
        @romans[column][row] = Roman.new(this)
      end
    end
  end
  
  def draw
    @romans.each
  end
end