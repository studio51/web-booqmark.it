module BootstrapDecorators
  module ButtonHelper

    def bmk_button(type, call, url, options = {})

      # params @type model/method: Defines type of action, either to a model or
      # an action
      # => model : [user, organisation, project]
      # => method: [new, show, custom]

      # params @call : Defines which model/action to execute
      # params @url : Defines the button' URL

      # params @options : Defines which attributes to apply to the button

      # locale ||= options[:attribute] || options[:model]

      title ||= options[:title]
      # => title : title

      data  ||= options[:data]
      # => data  : in most cases, wether you're using Bootstrap' tooltip, tab
      #            etc JS functions which require the 'data' attribute

      role  ||= options[:role]
      # => role  : same use as data, except as 'role'

      klass ||= classes(options[:klass])
      # => klass : add extra classes to the button, by default each class in
      #            array is appended with 'btn-'

      icon      ||= options[:icon_model]
      object    ||= options[:icon_object]
      attribute ||= options[:icon_attribute]
      pluralize ||= options[:icon_pluralize]
      target    ||= options[:target]

      if call == 'destroy'
        link_to bmk_icon(type, 'destroy'), url, title: title, data: { confirm: t("messages.info.confirm")}, method: :delete, class: klass
      else
        link_to bmk_icon(type, call, pluralize: pluralize, model: icon, object: object, attribute: attribute), url, title: title, data: data, role: role, target: target, class: klass
      end
    end

    private

      def classes(klass)
        unless klass.nil?
          curated_klass = klass.split.map { |c| "btn-#{c}" }
          curated_klass << 'btn'
        end
      end
  end
end
