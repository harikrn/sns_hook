# frozen_string_literal: true

module SNSHook
  module Helpers
    # Flash messages helper
    module FlashHelper
      def flash(key = :flash)
        @flash ||= {}
        @flash[key.to_sym] ||= Flash.new(parsed_flash(key.to_s) || {})
      end

      private

      def parsed_flash(key = 'flash')
        flash = request.cookies[key]
        return {} unless flash

        JSON.parse(flash)
      rescue JSON::ParserError
        {}
      end
    end
  end
end
