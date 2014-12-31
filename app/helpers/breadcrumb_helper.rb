module BreadcrumbHelper

  def breadcrumb_presenter
    breadcrumb = []
    progress = []

    url = request.path
    params = url.split('/')
    regex = /^[0-9]*$/

    params.shift
    params.each_with_index do |param, i|
      # Returns progress in array format and defines what the current url
      # for each object is
      progress << param

      # Joins the array values in a URL format/like/so
      url = progress.join('/')

      if param =~ regex
        # Returns the previous param from the array based on the Rails "way" where
        # an ID is allways followed by it's model.
        previous = params[i-1]
        klass = previous.classify

        object = klass.constantize.find(param).name rescue param
      else
        object = param.titleize
      end

      # Is the current URL the last? If so, add it as active and strip the URL
      if param != params.last
        breadcrumb.insert(i, content_tag(:li, link_to(param, root_path + url)))
      else
        breadcrumb.insert(i, content_tag(:li, object, class: "active"))
      end
    end

    if user_signed_in?
      content_tag :ul, class: "breadcrumb" do
        breadcrumb.insert(0, content_tag(:li, link_to(t("models.dashboard.name"), "/")))
        breadcrumb.join().html_safe
      end
    end
  end
end
