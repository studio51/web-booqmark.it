json.array!(@bookmarks) do |bookmark|
  json.extract! bookmark, :id, :url, :name, :description
  json.url bookmark_url(bookmark, format: :json)
end
