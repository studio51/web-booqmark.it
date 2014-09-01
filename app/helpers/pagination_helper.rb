# Change the default Will Paginate behavior and change it to match Bootstrap's Styles

module PaginationHelper
  class LinkRenderer < WillPaginate::ActionView::LinkRenderer

    protected
    # Builds the container around the navigation as we need an Unordered List for the
    # container rather than a div.

    def html_container( html )

      tag(:ul, html, container_attributes = { class: "pagination pagination-sm"})
    end

    # Pagination Page number

    def page_number( page )
      unless page == current_page
        # Makes all the available pages visible and adds 'next' relations as per Bootstrap
        # style and links to the current page
        #
        # <a href="controller?page=#" rel="next">#</a>

        link( page, page, rel: rel_value( page ))
      else
        # Makes the current page anchor visible and adds an 'active' class to it
        #
        # <a href="#" class="active">#</a>

        link( page, "#", class: 'active')
      end
    end

    def gap
      text = @template.will_paginate_translate(:page_gap) { '&hellip;' }

      %(<li class="disabled"><a>#{text}</a></li>)
    end

    def previous_page
      page_num = @collection.current_page > 1 && @collection.current_page - 1
      previous_or_next_page( page_num, (tag :i, '', class: "fa fa-chevron-left"), 'pagination_previous')
    end

    def next_page
      page_num = @collection.current_page < @collection.total_pages && @collection.current_page + 1
      previous_or_next_page( page_num, (tag :i, '', class: "fa fa-chevron-right"), 'pagination_next')
    end

    def previous_or_next_page( page, text, classname )
      if page
        link( text, page, class: classname )
      else
        link( text, "#", class: classname + ' disabled')
      end
    end

    private

    def link( text, target, attributes = {} )
      if target.is_a? Fixnum
        attributes[:rel] = rel_value(target)
        target = url(target)
      end

      unless target == "#"
        attributes[:href] = target
      end

      classname = attributes[:class]
      attributes.delete(:classname)
      tag(:li, tag(:a, text, attributes), class: classname)
    end
  end
end
