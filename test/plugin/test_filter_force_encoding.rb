require "helper"
require "fluent/plugin/filter_force_encoding"

class ForceEncodingFilterTest < Test::Unit::TestCase
  setup do
    Fluent::Test.setup
  end

  test "force encoding" do
    conf =<<~CONF
      <element>
         key host
         encoding us-ascii
      </element>
    CONF
    d = create_driver(conf)
    d.run(default_tag: "test") do
      d.feed({ "host" => "example.com".b, "message" => "test", "address" => "127.0.0.1".b })
    end
    assert_equal(Encoding::UTF_8, d.filtered_records.dig(0, "message").encoding)
    assert_equal(Encoding::US_ASCII, d.filtered_records.dig(0, "host").encoding)
    assert_equal(Encoding::BINARY, d.filtered_records.dig(0, "address").encoding)
  end

  test "nested key" do
    conf =<<~CONF
      <element>
         key $.parent.host
         encoding us-ascii
      </element>
    CONF
    d = create_driver(conf)
    d.run(default_tag: "test") do
      d.feed({ "parent" => { "host" => "example.com".b, "message" => "test", "address" => "127.0.0.1".b }})
    end
    assert_equal(Encoding::UTF_8, d.filtered_records.dig(0, "parent", "message").encoding)
    assert_equal(Encoding::US_ASCII, d.filtered_records.dig(0, "parent", "host").encoding)
    assert_equal(Encoding::BINARY, d.filtered_records.dig(0, "parent", "address").encoding)
  end

  private

  def create_driver(conf)
    Fluent::Test::Driver::Filter.new(Fluent::Plugin::ForceEncodingFilter).configure(conf)
  end
end
