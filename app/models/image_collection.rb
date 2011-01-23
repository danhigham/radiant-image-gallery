require 'rmagick'
class ImageCollection < ActiveRecord::Base
  has_many :images

  has_attached_file :header_image, 
                    #:styles => { :large => "800x600>", :thumb => "100x100>" },
                    :url => "/gallery/header/:id/header.png",
                    :path => ":rails_root/public/gallery/header/:id/header.png"
                    
  cattr_reader :per_page
  @@per_page = 9
                    
  def update_header
    image_stack = Array.new
    rotation = 0
    
    self.images.each do |x|
      x.display_order = 0 if x.display_order.nil? 
    end
    
    images = self.images.sort{|x,y| x.display_order <=> y.display_order}.first(4).reverse
    
    images.each do |image|
      rotation += 7
      img = Magick::Image::read(image.data.path(:medium)).first
      
      img = polaroid_effect(img, rotation)
      image_stack << img  
    end
    
    img = composite_stack(image_stack, -(rotation / 2))
    
    tempfile = Tempfile.new('header_image.png')
    img.write(tempfile.path) { self.quality = 100 }
    
    self.update_attributes!(:header_image => tempfile)
     
  end
  
  private 
  
  def polaroid_effect(image, rotation)
    image.border!(8, 8, "#f0f0ff")
    image.border!(1, 1, "#a9a9a9")

    # Bend the image
    image.background_color = "none"

    #amplitude = image.columns * 0.01        # vary according to taste
    #wavelength = image.rows  * 2

    #image.rotate!(90)
    #image = image.wave(amplitude, wavelength)
    #image.rotate!(-90)

    # Make the shadow
    #shadow = image.flop
    #shadow = shadow.colorize(1, 1, 1, "gray75")     # shadow color can vary to taste
    #shadow.background_color = "transparent"       # was "none"
    #shadow.border!(10, 10, "transparent")
    #shadow = shadow.blur_image(0, 3)        # shadow blurriness can vary according to taste

    # Composite image over shadow. The y-axis adjustment can vary according to taste.
    #image = shadow.composite(image, -amplitude/2, 5, Magick::OverCompositeOp)

    rotation_angle = rotation || (rand(10) - rand(10)) # random angle

    image.rotate!(rotation_angle)                       # vary according to taste
    image.trim!
    
    image
  end
  
  def composite_stack(image_stack, rotation)
    base_image = Magick::Image.new(400,400) {
      self.background_color = "none"
    }
    
    image_stack.each do |image|
      #x = rand(200 - image.columns)
      #y = rand(200 - image.rows)
      
      x = y = 0
      
      base_image.composite!(image, x, y, Magick::OverCompositeOp)
    end
    base_image.rotate!(rotation)
    base_image.trim!
    base_image.resize_to_fit(200,200)
  end

end
