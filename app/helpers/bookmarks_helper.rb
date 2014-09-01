module BookmarksHelper

  def tags_presenter tags
    if tags.any?
      if tags.length > 5
        remaining = tags.length - 5

        @tags = "#{tags.first(5).map { |t| link_to t, tag_path(t.parameterize)}.join(', ')} .. + #{remaining} more".html_safe
      else
        @tags = "#{tags.map { |t| link_to t, tag_path(t.parameterize)}.join(', ')}".html_safe
      end
    else
      @tags = fa_icon "", title: "This bookmark has no tags"
    end

    return fa_icon("tags") + @tags
  end
end
