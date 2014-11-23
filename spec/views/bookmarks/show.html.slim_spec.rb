require 'rails_helper'

RSpec.describe "bookmarks/show", :type => :view do
  before(:each) do
    @bookmark = assign(:bookmark, Bookmark.create!(
      :title => "Title",
      :url => "MyText",
      :name => "Name",
      :description => "Description",
      :thumbnail => "Thumbnail"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/Thumbnail/)
  end
end
