require 'gosu'

class Tutorial < Gosu::Window
    def initialize
        super 640, 480
        self.caption = "Tutorial Game"

        @background_image = Gosu::Image.new("media/space.png", :tileable => true)
    end

    def update
        if Gosu.button_down? Gosu::KB_LEFT or Gosu::button_down? Gosu::GP_LEFT
            @player.turn_left
        end
        if Gosu.button_down? Gosu::KB_RIGHT or Gosu::button_down? Gosu::GP_RIGHT
            @player.turn_right
        end
        if Gosu.button_down? Gosu::KB_UP or Gosu::button_down? Gosu::GP_BUTTON_0
            @player.accelerate
        end
        @player.move
    end

    def draw
        @player.draw
        @background_image.draw(0, 0, 0)
    end
end

def button_down(id) #Resume here!!!!!!!
Tutorial.new.show

class Player
    def initialize
        @image = Gosu::Image.new("media/starfighter.bmp")
        @x = @y = @vel_x = @vel_y = @angle = 0.0
        @score = 0
    end

    def warp(x, y)
        @x, @y = x, y
    end

    def turn_left
        @angle -= 4.5
    end

    def turn_right
        @angle += 4.5
    end

    def accelerate
        @vel_x += Gosu.offset_x(@angle, 0.5)
        @vel_y += Gosu.offset_y(@angle, 0.5)
    end

    def move
        @x += @vel_x
        @y += @vel_y
        @x %= 640
        @y %= 480

        @vel_x *= 0.95
        @vel_y *= 0.95
    end

    def draw
        @image.draw_rot(@x, @y, 1, @angle)
    end
end