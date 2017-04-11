module KrakenClient
  module Endpoints
    class Base

      attr_accessor :config, :options

      def initialize(config, options = {})
        @config  = config
        @options = options

        set_methods
      end

      def request_manager
        @request_manager ||= KrakenClient::Requests::Base.build(config, type)
      end

      private

      def set_methods
        data.each do |method, method_alias|
          self.class.send(:define_method, Array(method_alias).first) do |args = {}|
            raise_exception(Array(method_alias).last, args)

            perform(method.to_s, args)
          end
        end
      end

      def type
        @type ||= self.class.name.demodulize
      end

      def data
        fail ::KrakenClient::NotImplemented
      end

      def raise_exception
        return unless options.is_a?(Hash)

        leftover = options[:params] - args.keys

        if leftover.length > 0
          fail ::KrakenClient::ArgumentError, "Required options absent. Input must include #{leftover}"
        end
      end
    end
  end
end
