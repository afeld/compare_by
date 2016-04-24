require 'spec_helper'
require 'set'

describe CompareBy do
  class TestClass
    include CompareBy

    attr_accessor :some_attr
    compare_by :some_attr
  end

  it "has a version number" do
    expect(CompareBy::VERSION).not_to be nil
  end

  it "makes two instances ==" do
    instance1 = TestClass.new
    instance1.some_attr = 'foo'
    instance2 = TestClass.new
    instance2.some_attr = 'foo'

    expect(instance1 == instance2).to eq(true)
  end

  it "makes two instances #eql?" do
    instance1 = TestClass.new
    instance1.some_attr = 'foo'
    instance2 = TestClass.new
    instance2.some_attr = 'foo'

    expect(instance1.eql?(instance2)).to eq(true)
  end

  it "is unique in a Set" do
    instance1 = TestClass.new
    instance1.some_attr = 'foo'
    instance2 = TestClass.new
    instance2.some_attr = 'foo'

    set = [instance1, instance2].to_set
    expect(set.size).to eq(1)
  end
end
