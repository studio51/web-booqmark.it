module ApplicationHelper

  protected

  def will_paginate(collection_or_options = nil, options = {})
    if collection_or_options.is_a? Hash
      options, collection_or_options = collection_or_options, nil
    end

    unless options[:renderer]
      options = options.merge renderer: PaginationHelper::LinkRenderer
    end

    unless options[:per_page]
      WillPaginate.per_page = 15
    end

    super *[collection_or_options, options].compact
  end

  def link_for(url, classes = {})
    link_to url, args, class: "btn #{classes}"
  end

  def link_with_icon(method, url, args = {})
    title ||= args[:title]
    classes ||= args[:classes]

    if method == "delete"
      link_to(fa_icon(t("methods.#{method}.icon"), class: method), url, title: title, data: { confirm: t("messages.info.confirm") }, method: :delete,
 class: "btn #{classes}")
    else
      link_to(fa_icon(t("methods.#{method}.icon"), class: method), url, title: title, class: "btn #{classes}")
    end
  end
end
