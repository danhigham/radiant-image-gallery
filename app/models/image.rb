class Image < ActiveRecord::Base
  belongs_to :image_collection
  
  has_attached_file :data, 
                    :styles => { :large => "800x600>", :medium => "250x250", :thumb => "150x150>" },
                    :url => "/gallery/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/gallery/:id/:style/:basename.:extension"
  
  cattr_reader :per_page
  @@per_page = 9
end
