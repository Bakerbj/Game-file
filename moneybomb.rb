require 'gosu'

class Tutorial < Gosu::Window
    def initialize
        super 700, 460
        self.caption = "Tutorial Game"

        @background_image = Gosu::Image.new("media2/moneybomb.png", :tileable => true)

        @player = Player.new
        @player.warp(320, 410)

        
        @coin_img = Gosu::Image.new("media2/coin.png")
        @coins = Array.new
    end

    def update
        
        # @player.gravity
        if Gosu.button_down? Gosu::KB_LEFT or Gosu::button_down? Gosu::GP_LEFT
            @player.move_left
        end
        if Gosu.button_down? Gosu::KB_RIGHT or Gosu::button_down? Gosu::GP_RIGHT
            @player.move_right
        end
        # if Gosu.button_down? Gosu::KB_UP or Gosu::button_down? Gosu::GP_BUTTON_0
        #     @player.jump
        # end
        @player.move


        if rand(200) < 2 and @coins.size < 10
            @coins.push(Coin.new)
        end
    end

    def draw
        @background_image.draw(0, 0, ZOrder::BACKGROUND)
        @player.draw
        @coins.each { |coin| coin.draw }
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

    # def jump
    #     #@vel_y = 0

    #     if @y == 410
    #             @vel_y += Gosu.offset_y(0, 5)
    #     end
    # end

    # def gravity
    #     if @vel_y > 0
    #         @vel_y *= 0.95
    #     elsif @vel_y == 0 && @y <= 410
    #         @y - 10
    #     end
    # end

    def move
        @x += @vel_x
        @y += @vel_y
        @x %= 700
        @y %= 460

        @vel_x *= 0.95
    end

    def draw
        @image.draw_rot(@x, @y, 1, @angle)
    end
        
end

module ZOrder
    BACKGROUND, COINS, PLAYER, UI = *0..3
end

class Coin
    attr_reader :x, :y

    def initialize
        @color = Gosu::Color::BLACK.dup
        @color.red = 200
        @color.green = 300
        @color.blue = 0
        @x = rand * 620
        @y = 40
    end

  
    def draw
        image = Gosu::Image.new("media2/coin.png")
        image.draw(@x - image.width / 2.0, @y - image.height / 2.0,
        ZOrder::COINS, 1, 1, @color, :add)
    end
    # def fall
    #     @y = @y + 20
    #     @y %= 460
    # end

end



Tutorial.new.show