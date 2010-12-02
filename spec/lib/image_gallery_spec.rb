require File.dirname(__FILE__) + '/../spec_helper'

describe 'ImageGallery' do
  dataset :pages

  describe '<r:image_gallery>' do
    it 'should render the correct HTML' do
      tag = '<r:image_gallery" />'

      expected = %{<h2>Image Gallery</h2>}

      pages(:gallery).should render(tag).as(expected)
    end
  end
end