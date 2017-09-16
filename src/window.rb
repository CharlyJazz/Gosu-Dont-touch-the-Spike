require './src/config'
require './src/bird'
require './src/spike'

class DontTouchTheSpikes < Gosu::Window
  include ConfigWindow

  def initialize
    super ConfigWindow::WIDTH, ConfigWindow::HEIGHT

    self.caption = ConfigWindow::CAPTION

    @margin_color = ConfigWindow::MARGIN_COLOR

    @margin_width = ConfigWindow::MARGIN_WIDTH

    @font = Gosu::Font.new((@margin_width * 1.5).round)

    @background_image = ConfigWindow.get_background_image

    @bird = Bird.new(width / 2, height / 2, 2, 0)

    # This variable is for know the orientation of the spike
    # I Guess, draw left o right
    # The value should equal to 'right' || 'left'

    @spike_orientation = 'right'

    @spike_image = ConfigEntities.get_spike_image

    @score = 0

    @spikes = []
  end

  def listen_collition
    @spikes.each do |spike| # Check if the bird collition with the spikes
      if Gosu.distance(@bird.x, @bird.y, spike.x, spike.y) < @bird.image.width
        @bird.set_pain_x
        create_spikes
      end
    end
  end

  def listen_limit
    # Listen if the bird collapse with any limite
    x, y = @bird.x, @bird.y
    if x > ConfigWindow::WIDTH - @bird.image.width / 2
      create_spikes
      @bird.score += 1
    elsif x < 0 + @bird.image.width / 2
      create_spikes
      @bird.score += 1
    elsif y - @bird.image.height / 2 <= @margin_width + @spike_image.height
      # Pain and change orientation of bird
      @bird.set_pain_y
    elsif y + @bird.image.height / 2 >= height - @margin_width - @spike_image.height
      # Pain and change orientation of bird
      @bird.set_pain_y
    end
  end

  def create_spikes
    @spikes.clear
    if @spike_orientation == 'right'
      generate_array_y.each do |y|
        @spikes.push Spike.new(@margin_width + @spike_image.width / 2, y, false)
      end
      @spike_orientation = 'left'
    elsif @spike_orientation == 'left'
      generate_array_y.each do |y|
        @spikes.push Spike.new(width - @margin_width - @spike_image.width / 2, y, true)
      end
      @spike_orientation = 'right'
    end
  end

  def generate_array_y
    y_array = []
    min = 80
    max = height - @margin_width - @spike_image.height
    while y_array.length < 3
      if y_array.empty?
        y = rand(min..max * 33.333 / 100)
      elsif y_array.length == 1
        y = rand(@spike_image.height / 2 + max * 33.333 / 100..max * 66.666 / 100)
      elsif y_array.length == 2
        y = rand(@spike_image.height / 2 + max * 66.666 / 100..max * 99.999 / 100)
      end
      y_array.push y
    end
    y_array
  end

  def update
    @bird.update

    listen_limit
    listen_collition
  end

  def draw
    @bird.draw
    @background_image.draw(0, -20, 0)
    @font.draw("Score: #{@bird.score}", @margin_width / 2, -2, 2, 1, 1, Gosu::Color.argb(0xff_000000))

    # Draw the borders
    Gosu.draw_rect(0, 0, @margin_width, height, @margin_color)
    Gosu.draw_rect(width - @margin_width, 0, @margin_width, height, @margin_color)
    Gosu.draw_rect(0, 0, width, @margin_width, @margin_color)
    Gosu.draw_rect(0, height - @margin_width, width, @margin_width, @margin_color)

    # Draw spikes up and bottom
    5.times do |n|
      x_bottom = n * @margin_width / 3 + @spike_image.width \
                - @margin_width + n * @spike_image.width

      y_bottom = height - @spike_image.height / 2 - @margin_width

      x_top = n * @margin_width / 3 + @spike_image.width \
              - @margin_width + n * @spike_image.width

      t_top = 0 + @spike_image.height - @margin_width

      @spike_image.draw_rot(x_bottom, y_bottom, 1, 0)

      @spike_image.draw_rot(x_top, t_top, 1, 270 * 2)
    end

    @spikes.each &:draw
  end

  def button_down(id)
    if id == Gosu::KB_ESCAPE
      close
    else
      super
    end
  end
end