require 'rails_helper'

RSpec.describe "bookmarks/index", :type => :view do
  before(:each) do
    assign(:bookmarks, [
      Bookmark.create!(
        :title => "Title",
        :url => "MyText",
        :name => "Name",
        :description => "Description",
        :thumbnail => "Thumbnail"
      ),
      Bookmark.create!(
        :title => "Title",
        :url => "MyText",
        :name => "Name",
        :description => "Description",
        :thumbnail => "Thumbnail"
      )
    ])
  end

  it "renders a list of bookmarks" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "Thumbnail".to_s, :count => 2
  end
end
