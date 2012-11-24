ActionController::Routing::Routes.draw do |map|
  map.connect 'image_gallery/index', :controller => 'image_gallery', :action => 'index'   
  map.connect 'image_gallery/upload', :controller => 'image_gallery', :action => 'upload'
  map.connect 'image_gallery/delete_image', :controller => 'image_gallery', :action => 'delete_image'       
  map.connect 'image_gallery/delete_collection', :controller => 'image_gallery', :action => 'delete_collection'       
  map.connect 'image_gallery/reorder_images', :controller => 'image_gallery', :action => 'reorder_images'
  map.connect 'image_gallery/reorder_collections', :controller => 'image_gallery', :action => 'reorder_collections'
end