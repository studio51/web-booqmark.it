module CollectionsHelper

  def collection_image_presenter(c)
    icon = c.icon.exists?

    content_tag(:div, class: "bit-collection-image bit-collection-image-#{icon}") do
      if icon
        concat(image_tag(c.icon(:lg), class: 'img-responsive'))
      end
    end
  end

  def collection_bookmarks_presenter(layout, id, bookmarks)
    max_bookmarks = 10

    if layout && !bookmarks.nil?

      bookmarks_curator = bookmarks.map { |b| link_to(image_tag(b.snapshot(:sm), title: b.name, data: { toggle: 'tooltip', placement: 'top'}), bookmark_path(b)) }

      if bookmarks.length > max_bookmarks
        first_set = bookmarks_curator.first(max_bookmarks)
        last_set  = link_to("#{bookmarks.count - max_bookmarks} more..", collection_path(id), class: 'tag badge-primary')

        _bookmarks = first_set.insert(max_bookmarks, last_set)
      else
        _bookmarks = bookmarks_curator
      end


      content_tag(:div, class: 'bit-association bit-association-bookmarks') do
        _bookmarks.join.html_safe
      end
    end
  end
end
