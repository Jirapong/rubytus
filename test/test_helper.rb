require 'simplecov'
require 'minitest/autorun'
require 'minitest/pride'
require 'rr'
require 'goliath/test_helper'
require 'rubytus/error'
require 'rubytus/setup'
require 'rubytus/uid'

Goliath.env = :test

module Rubytus
  module Mock
    def pdf
      File.expand_path('../files/protocol.pdf', __FILE__)
    end

    def data_dir
      "/tmp/rubytus-#{rand(1000)}"
    end

    def remove_data_dir
      FileUtils.rm_rf(Dir.glob("/tmp/rubytus-*"))
    end

    def uid
      Rubytus::Uid.uid
    end

    def default_options
      {
        :data_dir  => data_dir,
        :max_size  => 1024 * 1024,
        :base_path => '/uploads/'
      }
    end

    class Config
      include Rubytus::Setup
    end
  end
end

module Goliath
  module TestHelper
    def server(api, port, options = {}, &blk)
      op = OptionParser.new

      s = Goliath::Server.new
      s.logger = setup_logger(options)
      s.api = api.new
      s.app = Goliath::Rack::Builder.build(api, s.api)
      s.api.options_parser(op, options)
      s.options = options
      s.port = port
      s.plugins = api.plugins
      s.api.setup if s.api.respond_to?(:setup)
      @test_server_port = s.port if blk
      s.start(&blk)
      s
    end
  end
end

