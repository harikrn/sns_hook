# frozen_string_literal: true

module SNSHook
  module Helpers
    # Helpers for managing urls
    module UrlHelper
      def active_class_for(target)
        'active' if current_path == target
      end

      def toaster_class(type)
        case type
        when 'success'
          'primary'
        when 'error'
          'danger'
        else
          'warning'
        end
      end

      private

      def home?
        current_path.split('/').count == 1
      end

      def current_path
        request.path.to_s
      end
    end
  end
end
