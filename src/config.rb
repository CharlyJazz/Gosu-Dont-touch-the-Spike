require 'gosu'

module Config
  IMAGE_FOLDER = File.expand_path('media/images')
end

module ConfigWindow
  include Config

  HEIGHT = 600
  WIDTH  = 350
  FILL_COLOR = Gosu::Color.argb(0xff_0000ff)
  MARGIN_COLOR = Gosu::Color.argb(0xff_00ffff)
  MARGIN_WIDTH = (WIDTH / 100) * 5
  CAPTION = 'Dont touch the spikes'

  @@background_image = 'background.png'

  def self.get_background_image
    image = File.join IMAGE_FOLDER, @@background_image
    Gosu::Image.new(image, :tileable => true)
  end
end

module ConfigEntities
  include Config

  @@bird_image  = 'bird.png'
  @@spike_image = 'spike.png'

  def self.get_bird_image
    image = File.join IMAGE_FOLDER, @@bird_image
    Gosu::Image.new(image)
  end

  def self.get_spike_image
    image = File.join IMAGE_FOLDER, @@spike_image
    Gosu::Image.new(image)
  end
end