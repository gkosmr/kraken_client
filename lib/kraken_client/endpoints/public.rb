module KrakenClient
  module Endpoints
    class Public < Base

      def perform(endpoint_name, args)
        response = request_manager.call(url(endpoint_name), args)
        hash = Hashie::Mash.new(JSON.parse(response.body))
        hash.has_key?(:result) ? hash[:result] : hash
      end

      def data
        {
          :Time       => :server_time,
          :AssetPairs => :asset_pairs,
          :Depth      => :order_book,
          :Ticker     => :ticker,
          :Trades     => :trades,
          :Spread     => :spread,
          :Assets     => :assets,
          :OHLC       => [:ohlc, params: [:pair]]
        }
      end

      private

      def url(endpoint_name)
        @url = config.base_uri + '/' + config.api_version.to_s + '/public/' + endpoint_name
      end
    end
  end
end
