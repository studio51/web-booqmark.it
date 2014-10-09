module BookmarksHelper

  def tags_presenter(tags)
    max_tags = 4

    if tags.any?
      if tags.length > max_tags
        remaining = tags.length - max_tags

        @tags = "#{tags.first(max_tags).map { |t| link_to t, tag_path(t.parameterize), class: 'tag'}.join} #{link_to remaining, '', class: 'last'}".html_safe
      else
        @tags = "#{tags.map { |t| link_to t, tag_path(t.parameterize), class: 'tag'}.join}".html_safe
      end
    else
      @tags = ""
    end

    content_tag :div, class: "bmk-tags" do
      fa_icon("tags") + @tags
    end
  end

  def time_presenter(time)
    time_ago_in_words(time) + " ago"
  end
end
