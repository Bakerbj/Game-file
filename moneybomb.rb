require 'gosu'

class Tutorial < Gosu::Window
    def initialize
        super 700, 460
        self.caption = "Tutorial Game"

        @background_image = Gosu::Image.new("media2/moneybomb.png", :tileable => true)

        @player = Player.new
        @player.warp(320, 240)
    end

    def update
        if Gosu.button_down? Gosu::KB_LEFT or Gosu::button_down? Gosu::GP_LEFT
            @player.move_left
        end
        if Gosu.button_down? Gosu::KB_RIGHT or Gosu::button_down? Gosu::GP_RIGHT
            @player.move_right
        end
        if Gosu.button_down? Gosu::KB_UP or Gosu::button_down? Gosu::GP_BUTTON_0
            @player.jump
        end
        @player.move
        
    end

    def draw
        @background_image.draw(0, 0, ZOrder::BACKGROUND)
        @player.draw
    end


    def button_down(id)
        if id == Gosu::KB_ESCAPE
            close
        else
            super
        end
    end
end


class Player
    attr_reader :score

    def initialize
        @image = Gosu::Image.new("media2/character.png")
        @beep = Gosu::Sample.new("media/beep.wav")
        @x = @y = @vel_x = @vel_y = @angle = 0.0
        @score = 0
    end

    def warp(x, y)
        @x, @y = x, y
    end

    def move_left
        @vel_x += Gosu.offset_x(270, 0.5)
    end

    def move_right
        @vel_x += Gosu.offset_x(90, 0.5)
    end

    def jump
        4.times do
            @vel_y += Gosu.offset_y(0, 0.5)
        end
    end


    def move
        @x += @vel_x
        @y += @vel_y
        @x %= 700
        @y %= 460

        @vel_x *= 0.95
        if @y == 200
            @vel_y = 0
        else
            @vel_y 
        end
    end

    def draw
        @image.draw_rot(@x, @y, 1, @angle)
    end
        
end

module ZOrder
    BACKGROUND, STARS, PLAYER, UI = *0..3
end

Tutorial.new.show