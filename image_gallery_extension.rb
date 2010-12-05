# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application_controller'

class ImageGalleryExtension < Radiant::Extension
  version "1.0"
  description "A simple image gallery that makes use of drag and drop uploading"
  url "http://yourwebsite.com/image_gallery"
  
  define_routes do |map|
    map.connect 'image_gallery/index', :controller => 'image_gallery', :action => 'index'   
    map.connect 'image_gallery/upload', :controller => 'image_gallery', :action => 'upload'
    map.connect 'image_gallery/delete_image', :controller => 'image_gallery', :action => 'delete_image'       
  end
  
  extension_config do |config|
       
      config.gem 'paperclip'
      config.gem 'rmagick'
      config.gem 'will_paginate'
  #   config.after_initialize do
  #     run_something
  #   end
  end

  # See your config/routes.rb file in this extension to define custom routes
  
  def activate
    Page.send :include, ImageGallery
  end
  
end
