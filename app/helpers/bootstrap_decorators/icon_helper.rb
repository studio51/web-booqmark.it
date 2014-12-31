module BootstrapDecorators
  module IconHelper

    def bmk_icon(type, call, options = {})

      fa_icon t("#{type.pluralize}.#{call}.icon", text: t("#{type.pluralize}.#{call}.name"))
    end
  end
end
