# encoding: utf-8
require 'bones/rpc/adapter'
require 'erlang/etf'

module Bones
  module RPC
    module Adapter
      module Erlang

        @adapter_name = :erlang

        def pack(message, buffer="")
          Packer.new(buffer).write(message)
        end

        def unpack(buffer)
          Unpacker.new(buffer).read
        end

        def unpacker(data)
          Unpacker.new(data)
        end

        def parser(data)
          Adapter::Parser.new(self, data)
        end

        def unpacker_pos(parser)
          parser.unpacker.buffer.pos
        end

        def unpacker_seek(parser, n)
          parser.unpacker.buffer.seek(n)
          return n
        end

        class Packer
          attr_reader :buffer

          def initialize(buffer = "")
            @buffer = buffer
          end

          def write(term)
            binary = ::Erlang.term_to_binary(term)
            head, = binary[0].unpack('C')
            data = binary[1..-1]
            Adapter.write_ext(head, data, buffer)
          end
        end

        class Unpacker
          attr_reader :buffer

          def initialize(data)
            @buffer = Bones::RPC::Parser::Buffer.new(data)
          end

          def read
            ext_data = Adapter.read_ext(buffer)
            ::Erlang.binary_to_term(ext_data)
          rescue NotImplementedError
            nil
          end
        end

        Adapter.register self
        Adapter.register_ext_head self, 131
      end
    end
  end
end
