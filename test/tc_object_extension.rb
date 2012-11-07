require "test/unit"
require File.expand_path('../../lib/vfeskov_edu_gem', __FILE__)

class TestObjectExtension < Test::Unit::TestCase

  class TestObject
    attr_accessor :property1
    attr_accessor :property2
    attr_accessor :property3
  end

  def test_array
    assert_equal('["123456","test string","test string 2"]', [123456,"test string","test string 2"].to_json )
  end

  def test_object
    t = TestObject.new()
    t.property1 = 123
    t.property2 = 'test string'
    t.property3 = [123, 'test string', 234]
    assert_equal('{"property1":"123","property2":"test string","property3":["123","test string","234"]}', t.to_json)
  end

  def test_object_in_object
    t1 = TestObject.new
    t1.property1 = 123
    t1.property2 = 'test string'
    t1.property3 = [123, 'test string', 234]

    t2 = TestObject.new
    t2.property1 = [t1,'asd']
    t2.property2 = [213,342,564]

    assert_equal('{"property1":[{"property1":"123","property2":"test string","property3":["123","test string","234"]},"asd"],"property2":["213","342","564"]}', t2.to_json)
  end


end