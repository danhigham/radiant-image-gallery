module ImageGallery
  include Radiant::Taggable
  
  
  desc "Adds gallery header libs to page"
  tag "image_gallery_headers" do |tag|
    
    page = tag.locals.page
    user = UserActionObserver.current_user
    view = response.template 
    controller = view.controller 
    
    script_headers = %{
      <script type="text/javascript" src="/javascripts/jquery-1.4.3.min.js"></script>
      <script type="text/javascript" src="/javascripts/jquery.colorbox-min.js"></script>
      <link href="/stylesheets/colorbox.css" media="screen" rel="stylesheet" type="text/css" /> 
      <link href="/stylesheets/gallery_base.css" media="screen" rel="stylesheet" type="text/css" /> 
    }
    
    if !user.nil?

      script_headers = %{
        #{script_headers}
        <script type="text/javascript" src="/javascripts/plupload/plupload.full.min.js"></script>
        <script type="text/javascript" src="/javascripts/plupload/jquery.plupload.queue.min.js"></script>
        <script type="text/javascript" src="/javascripts/gallery_admin.js"></script>
        <script type="text/javascript" src="/javascripts/jquery-ui-1.8.8.custom.min.js"></script>
        
        <link href="/stylesheets/plupload.queue.css" media="screen" rel="stylesheet" type="text/css" /> 
      }

    end
  
    %{#{script_headers}}
  end
  
  desc "Shows main gallery view"
  tag "image_collection" do |tag|

    page = tag.locals.page
    user = UserActionObserver.current_user
    view = response.template 
    controller = view.controller 

    collection_id = params[:id]
    collection = ImageCollection.find(collection_id)
    
    logged_in = !user.nil?
    
    if !logged_in
      images = collection.images.paginate :page => params[:page], :order => 'display_order ASC'
    else
      images = collection.images.all :order => 'display_order ASC'
    end
      
    gallery_page = tag.attr['gallery_page']
  
    view.content_tag :div, :id => 'image-collection' do 
      response.template.render(:partial => 'image_gallery/collection', 
        :locals => { :images => images, :collection => collection, :gallery_page => gallery_page, :logged_in => logged_in })
    end
    
  end
  
  desc "Creates a gallery on the page"
  tag "image_gallery" do |tag|

    page = tag.locals.page
    user = UserActionObserver.current_user
    view = response.template 
    controller = view.controller 
    
    logged_in = !user.nil?
  
    if !logged_in 
      image_collections = ImageCollection.paginate :page => params[:page], :order => 'display_order ASC'
    else
      image_collections = ImageCollection.all :order => 'display_order ASC'      
    end
    
    collection_page = tag.attr['collection_page']

    view.content_tag :div, :id => 'collections' do 
      response.template.render(:partial => 'image_gallery/index', :locals => { :collections => image_collections, :collection_page => collection_page, :logged_in => logged_in })
    end
  end
  
  desc "Adds an upload tag is the user is logged in"
  tag "gallery_upload" do |tag|
    user = UserActionObserver.current_user
    if !user.nil?
      %{ <a href="/image_gallery/upload" class="modal">Upload</a> }
    end
  end
      
end