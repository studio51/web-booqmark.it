module BookmarksHelper

  def image_presenter(b, regenerate = false)
    content_tag(:div, class: "col-sm-2") do
      content_tag(:div, class: 'booqmarkit-image') do
        concat(image_tag(b.snapshot(:lg), class: 'img-responsive'))

        if regenerate
          # if b.updated_at < Date.today
          concat(link_to fa_icon('refresh'), regenerate_bookmark_path(b.id), title: "Regenerate bookmark", data: { toggle: 'tooltip' })
          # end
        end
      end
    end
  end

  def name_presenter(name, url, limit = true)
    max_length = 55

    if name.length > max_length && limit
      link_to name.first(max_length - 2) + '..', url, title: name, data:
        { toggle: 'tooltip', placement: 'left' }
    else
      link_to name, url
    end
  end

  def description_presenter(description, limit = true)
    unless description.nil? || description == 'none'
      max_length = 180

      if description.length > max_length && limit
        _description = description.first(max_length - 2) + '..'
      else
        _description = description
      end

      content_tag(:p, class: 'booqmarkit-description') do
        _description
      end
    end
  end

  def collections_presenter(bookmark, collections, limit = true)
    unless collections.empty?
      max_collections = 1

      collections_curator = collections.map { |c| link_to(c.name, c, class: 'tag badge') }

      if collections.length > max_collections && limit
        first_set = collections_curator.first(max_collections)
        last_set  = link_to("#{collections.count - max_collections} more..", bookmark_path(bookmark), class: 'tag badge-primary')

        _collections = first_set.insert(max_collections, last_set)
      else
        _collections = collections_curator
      end

      content_tag(:div, class: 'booqmarkit-association collections') do
        fa_icon('folder') + _collections.join.html_safe
      end
    end
  end

  def tags_presenter(bookmark, tags, limit = true)
    unless tags.empty?
      max_tags = 7

      if tags.length > max_tags && limit
        first_set = tags.first(max_tags)
        last_set  = link_to("#{tags.from(max_tags).length} more..", bookmark_path(bookmark), title: tags.from(max_tags).map { |t| t }.join(', '), data: { toggle: 'tooltip', placement: 'top' }, class: 'tag badge-primary')

        _tags = first_set.insert(max_tags, last_set)
      else
        _tags = tags
      end

      content_tag(:div, class: 'booqmarkit-association tags') do
        fa_icon('tags') + tags_curator(_tags)
      end
    end
  end

  private

  def tags_curator(tags)
    tags.map do |t|
      link_to t, tag_path(t.parameterize), class: 'tag badge'
    end.join.html_safe
  end
end
