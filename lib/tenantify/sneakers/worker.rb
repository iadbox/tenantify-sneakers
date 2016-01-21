require 'tenantify'
require 'sneakers'

module Tenantify
  module Sneakers
    module Worker

      def self.prepended klass
        klass.send(:include, ::Sneakers::Worker)
      end

      def work_with_params msg, delivery_info, metadata
        tenant = metadata.fetch(:tenant)

        Tenantify.using tenant do
          if defined?(super)
            super
          else
            work(msg)
          end
        end
      end

    end
  end
end
