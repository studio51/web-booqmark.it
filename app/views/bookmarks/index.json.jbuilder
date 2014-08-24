json.array!(@bookmarks) do |bookmark|
  json.extract! bookmark, :id, :title, :url, :name, :description, :thumbnail
  json.url bookmark_url(bookmark, format: :json)
end
