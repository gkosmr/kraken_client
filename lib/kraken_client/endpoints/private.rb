module KrakenClient
  module Endpoints
    class Private < Base

      def perform(endpoint_name, args)
        url      = config.base_uri + url_path(endpoint_name)
        result   = request_manager.call(url, endpoint_name, args)
        Hashie::Mash.new({ result: result}).result
      end

      def data
        {
          :Balance            => :balance,
          :TradeBalance       => :trade_balance,
          :OpenOrders         => :open_orders,
          :ClosedOrders       => :closed_orders,
          :QueryOrders        => [:query_orders,  params: [:txid]],
          :TradesHistory      => :trades_history,
          :QueryTrades        => [:query_trades,  params: [:txid]],
          :OpenPositions      => :open_positions, params: [:txid],
          :Ledgers            => :ledgers,
          :QueryLedgers       => [:query_ledgers, params: [:id]],
          :TradeVolume        => :trade_volume,
          :AddOrder           => [:add_order,     params: [:pair, :type, :ordertype, :volume]],
          :CancelOrder        => [:cancel_order,  params: [:txid]],
          :DepositMethods     => [:deposit_methods, params: [:asset]],
          :DepositAddresses   => [:deposit_addresses, params: [:asset, :method]],
          :Withdraw           => [:withdraw, params: [:asset, :key, :amount]],
          :WithdrawInfo       => [:withdraw_info, params: [:asset, :key, :amount]]
        }
      end

      private

      def url_path(method)
        '/' + config.api_version.to_s + '/private/' + method
      end
    end
  end
end
