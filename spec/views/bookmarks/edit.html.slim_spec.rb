require 'rails_helper'

RSpec.describe "bookmarks/edit", :type => :view do
  before(:each) do
    @bookmark = assign(:bookmark, Bookmark.create!(
      :title => "MyString",
      :url => "MyText",
      :name => "MyString",
      :description => "MyString",
      :thumbnail => "MyString"
    ))
  end

  it "renders the edit bookmark form" do
    render

    assert_select "form[action=?][method=?]", bookmark_path(@bookmark), "post" do

      assert_select "input#bookmark_title[name=?]", "bookmark[title]"

      assert_select "textarea#bookmark_url[name=?]", "bookmark[url]"

      assert_select "input#bookmark_name[name=?]", "bookmark[name]"

      assert_select "input#bookmark_description[name=?]", "bookmark[description]"

      assert_select "input#bookmark_thumbnail[name=?]", "bookmark[thumbnail]"
    end
  end
end
