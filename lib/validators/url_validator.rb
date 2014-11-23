require 'active_support/core_ext/array/wrap'
require 'uri'

module ActiveModel
  module Validations
    class UrlValidator < EachValidator

      def initialize(options)
        options[:protocols] ||= options.delete(:protocol) || options.delete(:with) || options.delete(:in)
        super
      end

      def check_validity!
        raise ArgumentError, 'At least one URI protocol is required' if protocols.empty?
      end

      def protocols
        Array.wrap(options[:protocols] || %w{http https})
      end

      def uri_regexp
        @uri_regexp ||= /\A#{URI.regexp(protocols)}\z/
      end

      def as_uri(value)
        URI.parse(value.to_s) rescue nil if value.present?
      end

      def validate_each(record, attribute, value)
        uri = as_uri(value)
        record.errors.add(attribute) unless uri && value.to_s =~ uri_regexp
      end
    end
  end
end
