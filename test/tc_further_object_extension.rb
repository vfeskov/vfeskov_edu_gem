require "test/unit"
require File.expand_path('../../lib/vfeskov_edu_gem', __FILE__)
require File.expand_path('../common/test_object', __FILE__)
class FurtherObjectExtensionTest < Test::Unit::TestCase

  def test_to_be_serialized

    t = TestObject.new
    t.property1 = 123
    t.property2 = 'test string'
    t.property3 = [123, 'test string', 234]

    VfeskovEduGem.extend_to_json(t)

    t.to_be_serialized(:property1, :property2)
    assert_equal('{\"property1\":\"123\",\"property2\":\"test string\"}', t.to_json)

  end

  def test_to_json_for

    t = TestObject.new
    t.property1 = 123
    t.property2 = 'test string'
    t.property3 = [123, 'test string', 234]

    VfeskovEduGem.extend_to_json(t)

    t.to_be_serialized(:property1, :property2)

    assert_equal('{\"property1\":\"123\",\"property3\":[\"123\",\"test string\",\"234\"]}', t.to_json_for_property1_and_property3)

    assert_equal('{\"property1\":\"123\",\"property2\":\"test string\",\"property3\":[\"123\",\"test string\",\"234\"]}', t.to_json_for_property1_and_property2_and_property3)

    assert_equal('{\"property1\":\"123\",\"property2\":\"test string\"}', t.to_json)

  end

  def test_escape_special_characters

    t = TestObject.new
    t.property1 = 'bill@gates.cool'
    t.property2 = 'he said "go"'
    t.property3 = ['\'guys\' & co', '\--||--/', 234]

    assert_equal('{"property1":"bill@gates.cool","property2":"he said "go"","property3":["\'guys\' & co","\--||--/","234"]}', t.to_json)

    VfeskovEduGem.extend_to_json(t)

    assert_equal('{\"property1\":\"bill\@gates.cool\",\"property2\":\"he said \"go\"\",\"property3\":[\"\\\'guys\\\' \& co\",\"\\\--||--\/\",\"234\"]}', t.to_json)

  end

end