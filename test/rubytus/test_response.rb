require 'test_helper'

class TestResponse < MiniTest::Unit::TestCase
  def setup
    @response = Rubytus::Response.new
  end

  def test_initialize
    assert_equal 'text/plain; charset=utf-8', @response.headers['Content-Type']
    assert_equal '*', @response.header['Access-Control-Allow-Origin']

    assert_equal 'HEAD,GET,PUT,POST,PATCH,DELETE',
      @response.header['Access-Control-Allow-Methods']

    assert_equal 'Origin, X-Requested-With, Content-Type, Accept, Content-Disposition, Final-Length, Offset',
      @response.header['Access-Control-Allow-Headers']

    assert_equal 'Location, Range, Content-Disposition, Offset',
      @response.header['Access-Control-Expose-Headers']
  end
end