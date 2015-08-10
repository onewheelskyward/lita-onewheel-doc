module Lita
  module Handlers
    class OnewheelDoc < Handler
      REDIS_KEY = 'onewheel-doc'

      route /^docdel\s+([\w\/+_-]+)$/, :del_key, command: true,
          help: '!docdel key              removes a key'
      route /^doc\s+([\w\/+_-]+)\s+(.*)$/, :add_key, command: true,
          help: '!doc key_val http://     Add a key using key_val and the http link'
      route /^doc$/, :list_keys, command: true,
          help: '!doc                     list all keys'
      route /^doc\s+(\w+)$/, :fetch_key, command: true,
          help: '!doc key_val             fetch the value for key_val'

      def add_key(response)
        key = response.matches[0][0]
        value = response.matches[0][1]
        redis.hset(REDIS_KEY, key, value)
        response.reply "Documented #{key} as #{value}"
      end

      def fetch_key(response)
        key = response.matches[0][0]

        reply = redis.hget(REDIS_KEY, key)

        # If we didn't find an exact key, perform a substring match
        if reply.nil?
          values = []
          all = redis.hgetall(REDIS_KEY)
          all.each do |all_key, all_val|
            if all_key =~ /^#{key}/
              values.push "#{all_key}: #{all_val}"
            end
          end
          reply = values.join "\n"
        end
        response.reply reply
      end

      def list_keys(response)
        replies = []

        all = redis.hgetall(REDIS_KEY)
        all.each do |key, val|
          replies.push "#{key}: #{val}"
        end
        response.reply replies.join "\n"
      end

      def del_key(response)
        key = response.matches[0][0]
        y = redis.hdel(REDIS_KEY, key)
        response.reply "Document deleted: #{key}"
      end
    end

    Lita.register_handler(OnewheelDoc)
  end
end
