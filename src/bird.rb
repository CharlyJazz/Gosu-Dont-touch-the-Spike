require './src/config'

class Bird
  attr_accessor :x, :y, :vel_x, :vel_y, :score
  attr_reader :image

  include ConfigWindow

  def initialize(x, y, vel_x, vel_y)
    @x = x
    @y = y
    @vel_x = vel_x
    @vel_y = vel_y
    @angle = 0.1
    @image = ConfigEntities.get_bird_image
    @jump_power = 1
    @score = 0
  end

  def draw
    @image.draw_rot(@x, @y, 1, @angle) # Draw the bird
  end

  def move
    # Moving dinamic
    @x += @vel_x
    @y += @vel_y

    @vel_y = @vel_y + 0.3 + calc_impulse

    if @x > ConfigWindow::WIDTH - @image.width / 2
      @vel_x *= -1

    elsif @x < 0 + @image.width / 2
      @vel_x *= -1

    elsif @y > ConfigWindow::HEIGHT - @image.height / 2
      @vel_y *= -1

    elsif @y <= 0
      @vel_y *= -1
    end
  end

  def calc_impulse
    # # Add insane dificulty shit fucking satanic
    return 0 if @score.zero? || !(@score % 4).zero?
    Math.log(rand(1.5..2.5)) / 4
  end


  def set_pain_y
    @vel_y *= -1
    @score > 1 ? @score -= 2 : @score = 0
  end

  def set_pain_x
    @vel_x *= -1
    @score -= 1 if @score > 0
  end

  def up
    @vel_y -= @jump_power # Bird jump
  end

  def update
    if Gosu.button_down? Gosu::KB_SPACE
      up
    end
    move # Wrapper bird methods that need update in the game loop
  end

end