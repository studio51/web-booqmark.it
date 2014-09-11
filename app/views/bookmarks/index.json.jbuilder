json.array!(@bookmarks) do |bookmark|
  json.extract! bookmark, :id, :name
  json.url bookmark_url(bookmark, format: :json)
end
