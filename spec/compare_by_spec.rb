require 'spec_helper'

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
end
