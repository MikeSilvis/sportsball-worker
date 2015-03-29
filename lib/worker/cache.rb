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

      def clear
        client.flush
      end

      private

      def client
        @cache ||= Dalli::Client.new((ENV["MEMCACHEDCLOUD_SERVERS"] || "").split(","), {
          username: ENV["MEMCACHEDCLOUD_USERNAME"],
          password: ENV["MEMCACHEDCLOUD_PASSWORD"],
          failover: true,
          socket_timeout: 1.5,
          socket_failure_delay: 0.2
        })
      end
    end
  end
end
