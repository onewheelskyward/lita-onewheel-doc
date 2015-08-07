module Lita
  module Handlers
    class OnewheelDoc < Handler
      route /^doc\s+(\w+)\s+(.*)$/, :add_key, command: true,
          help: '!doc key_val http://     Add a key using key_val and the http link'
      route /^doc$/, :list_keys, command: true,
          help: '!doc                     list all keys'
      route /^doc\s+(\w+)$/, :fetch_key, command: true,
          help: '!doc key_val             fetch the value for key_val'
    end

    Lita.register_handler(OnewheelDoc)
  end
end
