module ApplicationHelper

  protected

  def will_paginate collection_or_options = nil, options = {}
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
end
