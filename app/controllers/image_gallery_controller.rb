class ImageGalleryController < ApplicationController
  layout :except => ''
   
  def index
      
  end
  
  def upload
    if request.post?

      filename = params[:name]
      image = Image.create(:data => params[:file]) #, :data_file_name => filename)

      if (params[:new_collection_name] != '')
        collection = ImageCollection.find_or_create_by_name(params[:new_collection_name])
        collection.description = params[:new_collection_desc]
      else
        collection = ImageCollection.find(params[:existing_collection])
      end
      
      collection.images << image
      collection.save

      collection.update_header
      
      render :text => 'OK'
    else
      @collections = ImageCollection.all
      
      render
    end
  end
  
end
