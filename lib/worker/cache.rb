require 'dalli'

module Worker
  class Cache
    class << self
      def fetch(cache_key, attrs, &block)
        return read(cache_key) if read(cache_key)

        write(cache_key, yield)

        return read(cache_key)
      end

      def read(cache_key)
        client.get cache_key
      end

      def write(cache_key, data, attrs = {})
        client.set cache_key, data
      end

      private

      def client
        @cache ||= Dalli::Client.new((ENV["MEMCACHIER_SERVERS"] || "").split(","), {
          username: ENV["MEMCACHIER_USERNAME"],
          password: ENV["MEMCACHIER_PASSWORD"],
          failover: true,
          socket_timeout: 1.5,
          socket_failure_delay: 0.2
        })
      end
    end
  end
end
