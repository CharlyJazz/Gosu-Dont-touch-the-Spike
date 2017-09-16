class Spike
  attr_accessor :x, :y, :bool
  attr_reader :angle_right, :image

  include ConfigWindow

  def initialize(x, y, bool)
    @x = x
    @y = y
    @bool = bool
    @image = ConfigEntities.get_spike_image
    @angle_right = 270
  end

  def draw
    if @bool # if bool si true then draw the spikes right
      @image.draw_rot(@x, @y, 1, @angle_right)
    else # else the spikes left
      @image.draw_rot(@x, @y, 1, @angle_right * 3)
    end
  end
end