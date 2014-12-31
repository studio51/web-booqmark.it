module ApplicationHelper

  protected

  def nav_link model, path
    params = request.path.split("/").map{ |param| "/" + param }
    params.shift

    active = "active" if params.first.eql?(path)

    content_tag :li, class: active do
      link_to model.pluralize, path, title: model.pluralize
    end
  end

  def will_paginate(collection_or_options = nil, options = {})
    if collection_or_options.is_a? Hash
      options, collection_or_options = collection_or_options, nil
    end

    unless options[:renderer]
      options = options.merge renderer: PaginationHelper::LinkRenderer
    end

    super *[collection_or_options, options].compact
  end

  def link_for(url, classes = {})
    link_to url, args, class: "btn #{classes}"
  end

  def booqmarkit_url_helper(method, action, url)
    if action == 'destroy'
      link_to fa_icon(t("methods.#{action}.icon")), url, method: :delete, data: { confirm: "Are you sure?" }, class: "booqmarkit-button #{action}"
    else
      link_to fa_icon(t("methods.#{action}.icon")), url, class: "booqmarkit-button #{action}"
    end
  end
end
