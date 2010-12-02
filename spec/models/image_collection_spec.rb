require File.dirname(__FILE__) + '/../spec_helper'

describe ImageCollection do
  before(:each) do
    @image_collection = ImageCollection.new
  end

  it "should be valid" do
    @image_collection.should be_valid
  end
end
